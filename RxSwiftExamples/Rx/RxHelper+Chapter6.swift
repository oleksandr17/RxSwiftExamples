//

import RxSwift
import RxCocoa

extension RxHelper {
    
    static func runChapter6() {
        example(title: "ignoreElements", action: ignoreElements)
        example(title: "throttle", action: throttle)
        example(title: "take", action: take)
    }
    
    private static func ignoreElements() {
        let disposeBag = DisposeBag()
        
        Observable<Int>.create { observer in
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
//            observer.onCompleted()
            observer.onError(RxError.emptyError)
            return Disposables.create()
            }
            .ignoreElements()
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func throttle() {
        let disposeBag = DisposeBag()
        
        Observable<Int>.create { observer in
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onCompleted()
            return Disposables.create()
            }
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func take() {
        let disposeBag = DisposeBag()
        
        Observable<Int>.create { observer in
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onCompleted()
            return Disposables.create()
            }
            .take(5.0, scheduler: MainScheduler.instance)
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
}
