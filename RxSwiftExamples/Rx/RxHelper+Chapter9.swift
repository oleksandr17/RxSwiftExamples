//

import RxSwift
import RxCocoa

extension RxHelper {
    
    static func runChapter9() {
        example(title: "startWith", action: startWith)
        example(title: "concut", action: concat)
        example(title: "concatOneElement", action: concatOneElement)
        example(title: "merge", action: merge)
        example(title: "combineLatest", action: combineLatest)
        example(title: "zip", action: zip)
        example(title: "withLatestFrom", action: withLatestFrom)
        example(title: "sample", action: sample)
        example(title: "amb", action: amb)
        example(title: "switchLatest", action: switchLatest)
        example(title: "reduce", action: reduce)
        example(title: "scan", action: scan)
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
        
        //
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
        
        observable
            .subscribe { (event) in
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
        second.onError(RxError.emptyError)
    }
    
    private static func combineLatest() {
        let disposeBag = DisposeBag()
        
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        let observable = Observable.combineLatest(first, second) { v1, v2 in
            return (v1, v2)
        }
        observable
            .subscribe { (event) in
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
        second.onError(RxError.emptyError)
        
        //
        let bools = Observable<Bool>.of(true, false)
        let numbers = Observable<Int>.of(1, 2, 3)
        let observable2 = Observable<Int>.combineLatest(bools, numbers) { v1, v2 in
            if v1 {
                return v2
            }
            return -v2
        }
        observable2
            .subscribe { (event) in
                print("2) \(event)")
            }
            .disposed(by: disposeBag)
        
    }
    
    private static func zip() {
        let disposeBag = DisposeBag()
        
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        let observable = Observable.zip(first, second) { v1, v2 in
            return (v1, v2)
        }
        observable
            .subscribe { (event) in
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
        second.onError(RxError.emptyError)
    }
    
    private static func withLatestFrom() {
        let disposeBag = DisposeBag()
        
        let button = PublishSubject<Void>()
        let textField = PublishSubject<String>()
        
        let observable = button.withLatestFrom(textField)
        observable
            .subscribe { (event) in
                print(event)
            }
            .disposed(by: disposeBag)
        
        textField.onNext("Par")
        textField.onNext("Pari")
        textField.onNext("Paris")
        button.onNext(())
        button.onNext(())
    }
    
    private static func sample() {
        let disposeBag = DisposeBag()
        
        let button = PublishSubject<Void>()
        let textField = PublishSubject<String>()
        
        let observable = textField.sample(button)
        observable
            .subscribe { (event) in
                print(event)
            }
            .disposed(by: disposeBag)
        
        textField.onNext("Par")
        textField.onNext("Pari")
        textField.onNext("Paris")
        button.onNext(())
        button.onNext(())
    }
    
    private static func amb() {
        let disposeBag = DisposeBag()
        
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        
        let observable = first.amb(second)
        observable
            .subscribe(onNext: { value in
                print(value)
            })
            .disposed(by: disposeBag)
        
        first.onNext("Lisbon")
        second.onNext("Copenhagen")
        first.onNext("London")
        first.onNext("Madrid")
        second.onNext("Vienna")
    }
    
    private static func switchLatest() {
        // It's similar to `flatMapLatest` (chapter 7)
        let disposeBag = DisposeBag()
        
        let one = PublishSubject<String>()
        let two = PublishSubject<String>()
        let three = PublishSubject<String>()
        let source = PublishSubject<Observable<String>>()
        
        let observable = source.switchLatest()
        observable
            .subscribe(onNext: { value in
                print(value)
            })
            .disposed(by: disposeBag)
        
        source.onNext(one)
        one.onNext("Some text from sequence one")
        two.onNext("Some text from sequence two")
        
        source.onNext(two)
        two.onNext("More text from sequence two")
        one.onNext("and also from sequence one")
        
        source.onNext(three)
        two.onNext("Why don't you seem me?")
        one.onNext("I'm alone, help me")
        three.onNext("Hey it's three. I win.")
        
        source.onNext(one)
        one.onNext("Nope. It's me, one!")
    }
    
    private static func reduce() {
        let disposeBag = DisposeBag()
        
        let source = Observable.of(1, 3, 5, 7, 9)
        
        let observable = source.reduce(0, accumulator: { summary, newValue in
            return summary + newValue
        })
        observable
            .subscribe(onNext: { value in
                print(value)
            })
            .disposed(by: disposeBag)
    }
    
    private static func scan() {
        let disposeBag = DisposeBag()
        
        let source = Observable.of(1, 3, 5, 7, 9)
        let observable = source.scan(0, accumulator: +)
        observable
            .subscribe(onNext: { value in
                print(value)
            })
            .disposed(by: disposeBag)
    }
}
