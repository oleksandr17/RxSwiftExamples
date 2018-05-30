import RxSwift
import RxCocoa

extension RxHelper {
    
    static func runChapter9() {
        example(title: "startWith", action: startWith)
        example(title: "concut", action: concat)
        example(title: "concatOneElement", action: concatOneElement)
        example(title: "merge", action: merge)
    }
    
    private static func startWith() {
        let disposeBag = DisposeBag()
        
        let numbers = Observable.of(1, 2, 3)
        let observable = numbers.startWith(0)
        observable
            .subscribe(onNext: { (value) in
                print(value)
            })
            .disposed(by: disposeBag)
    }
    
    private static func concat() {
        let disposeBag = DisposeBag()
        
        let first = Observable.of(1, 2, 3)
        let second = Observable.of(10, 20, 30)
        let observable1 = Observable.concat([first, second])
        observable1
            .subscribe(onNext: { (value) in
                print("1) \(value)")
            })
            .disposed(by: disposeBag)
        
        let observable2 = first.concat(second)
        observable2
            .subscribe(onNext: { (value) in
                print("2.1) \(value)")
            })
            .disposed(by: disposeBag)
        
        observable2
            .subscribe(onNext: { (value) in
                print("2.2) \(value)")
            })
            .disposed(by: disposeBag)
    }
    
    private static func concatOneElement() {
        // A bit cleaner version of `startWith`
        let disposeBag = DisposeBag()
        
        let numbers = Observable.of(1, 2, 3)
        Observable
            .just(0)
            .concat(numbers)
            .subscribe(onNext: { (value) in
                print(value)
            })
            .disposed(by: disposeBag)
    }
    
    private static func merge() {
        let disposeBag = DisposeBag()
        
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        let source = Observable.of(first.asObservable(), second.asObservable())
        let observable = source.merge()
        
        observable.subscribe { (event) in
            print(event)
            }
            .disposed(by: disposeBag)
        
        first.onNext("1) A")
        first.onNext("1) B")
        first.onNext("1) C")
        second.onNext("2) D")
        second.onNext("2) E")
        second.onNext("2) F")
        first.onNext("1) G")
        second.onNext("2) H")
        first.onCompleted()
        second.onCompleted()
        second.onError(RxError.defaultError)
    }
}
