//

import RxSwift
import RxCocoa
import Photos

extension RxHelper {
    
    static func runMisc() {
//        example(title: "catchErrorJustReturn", action: catchErrorJustReturn)
//        example(title: "photosAuthorised", action: photosAuthorised)
    }
    
    private static func catchErrorJustReturn() {
        let disposeBag = DisposeBag()
        
        let subject = PublishSubject<String>()
        subject
            .catchErrorJustReturn("supress error")
            .subscribe { event in
                print(event)
            }
            .disposed(by: disposeBag)
        
        subject.onNext("next")
        subject.onError(RxError.defaultError)
    }
    
    private static func photosAuthorised() {
        // This example makes sure that UI is updated once user grants access to photo library.
        // Any immediate measurements of Rx resources will tell about memory leaks. It happens because an `observer` is hold by `DispatchQueue.main`.
        let disposeBag = DisposeBag()
        
        Observable<Bool>.create { observer in
            DispatchQueue.main.async {
                if PHPhotoLibrary.authorizationStatus() == .authorized {
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    observer.onNext(false)
                    PHPhotoLibrary.requestAuthorization { newStatus in
                        observer.onNext(newStatus == .authorized)
                        observer.onCompleted()
                    }
                } }
            return Disposables.create()
            }
            .share()
            .skipWhile { $0 == false }
            .take(1)
            .subscribe(onNext: { granted in
                DispatchQueue.main.async {
                    print("Photo library access: \(granted)")
                }
            })
            .disposed(by: disposeBag)
    }
}
