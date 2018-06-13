//

import RxSwift
import RxCocoa

extension RxHelper {
    
    static func runChapter14() {
        example(title: "catchErrorJustReturn", action: catchErrorJustReturn)
        example(title: "catchError", action: catchError)
        example(title: "retry", action: retry)
        example(title: "throwError", action: throwError)
    }
    
    private static func catchErrorJustReturn() {
        let disposeBag = DisposeBag()
        
        let subject = PublishSubject<String>()
        subject
            .catchErrorJustReturn("error occured")
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        subject.onError(RxError.emptyError)
    }
    
    private static func catchError() {
        let disposeBag = DisposeBag()
        
        let subject = PublishSubject<String>()
        subject
            .catchError({ (error) -> Observable<String> in
                return Observable.just("error occured: \(error)")
            })
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        subject.onError(RxError.stringError(value: "hello"))
    }
    
    private static func retry() {
        var sendError = true
        let observable = Observable<Int>.create { observer in
            observer.on(.next(1))
            observer.on(.next(2))
            observer.on(.next(2))
            if sendError {
                sendError = false
                observer.onError(RxError.emptyError)
            } else {
                observer.onCompleted()
            }
            return Disposables.create()
        }
        
        _ = observable.retryWhen { (error: Observable<RxError>) -> Observable<Int> in
            let observable = error.flatMap { (error: RxError) -> Observable<Int> in
                if case RxError.emptyError = error {
                    return Observable<Int>.just(1)
                } else {
                    return Observable<Int>.error(error)
                }
            }
            return observable
            }
            .subscribe { event in
                print("\(event)")
        }
    }
    
    private static func throwError() {
        _ = timerObservable(interval: 1, count: 5, queue: .main)
            .do(onNext: { (value) in
                if value > 2 {
                    throw RxError.emptyError
                }
            })
            .subscribe { event in
                print("\(event)")
            }
    }
}
