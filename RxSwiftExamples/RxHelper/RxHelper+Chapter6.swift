//

import RxSwift
import RxCocoa

extension RxHelper {
    
    static func runChapter6() {
        example(title: "share", action: share)
        example(title: "ignoreElements", action: ignoreElements)
        example(title: "throttle", action: throttle)
        example(title: "take", action: take)
    }
    
    private static func share() {
        let disposeBag = DisposeBag()
        
        let observable = Observable<Int>.create { observer in
            let start = Int(arc4random_uniform(100_000))
            observer.onNext(start)
            observer.onNext(start+1)
            observer.onNext(start+2)
            observer.onCompleted()
            return Disposables.create()
        }
        
        observable
            .subscribe { event in
                print("1) \(event)")
            }
            .disposed(by: disposeBag)
        
        observable
            .subscribe { event in
                print("2) \(event)")
            }
            .disposed(by: disposeBag)
        
        // Share doesn't work because first subscription is completed before second even starts
        observable.share()
            .subscribe { event in
                print("share 1) \(event)")
            }
            .disposed(by: disposeBag)
        
        observable.share()
            .subscribe { event in
                print("share 2) \(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func ignoreElements() {
        let disposeBag = DisposeBag()
        
        Observable<Int>.create { observer in
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
//            observer.onCompleted()
            observer.onError(RxError.defaultError)
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
