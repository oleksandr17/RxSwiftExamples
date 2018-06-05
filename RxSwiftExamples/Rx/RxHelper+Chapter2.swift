//

import RxSwift
import RxCocoa

extension RxHelper {
    
    static func runChapter2() {
        example(title: "intro", action: intro)
        example(title: "range", action: range)
        example(title: "create", action: create)
        example(title: "empty", action: empty)
    }
    
    private static func intro() {
        let disposeBag = DisposeBag()
        
        let one = 1
        let two = 2
        let three = 3
        
        let observable1 = Observable<Int>.just(one)
        let observable2 = Observable.of([one, two, three])
        let observable3 = Observable.of(one, two, three)
        let observable4 = Observable.from([one, two, three])
        
        observable1.subscribe(onNext: { (element) in
            print("1) \(element)")
        }, onError: nil,
           onCompleted: {
            print("1) completed")
        }) {
            print("1) disposed")
        }
        .disposed(by: disposeBag)
        
        observable2.subscribe{ event in
            print("2) \(event)")
        }
        .disposed(by: disposeBag)
        
        observable3.subscribe{ event in
            print("3) \(event)")
        }
        .disposed(by: disposeBag)
        
        observable4.subscribe{ event in
            print("4) \(event)")
        }
        .disposed(by: disposeBag)
    }
    
    private static func range() {
        let disposeBag = DisposeBag()
        
        let observable = Observable<Int>.range(start: 1, count: 10)
        observable
            .subscribe(onNext: { element in
                let n = Double(element)
                let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
                print("\(fibonacci)")
            }){
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    private static func create() {
        let disposeBag = DisposeBag()
        
        let observable = Observable<String>.create { observer in
            observer.onNext("1")
            observer.onError(RxError.defaultError)
            observer.onCompleted()
            observer.onNext("?")
            return Disposables.create()
        }
        
        observable.subscribe(
            onNext: { print("1) \($0)") },
            onError: { print("1) \($0)") },
            onCompleted: { print("1) completed") },
            onDisposed: { print("1) disposed") }
            )
            .disposed(by: disposeBag)
        
        observable.subscribe(
            onNext: { print("2) \($0)") },
            onError: { print("2) \($0)") },
            onCompleted: { print("2) completed") },
            onDisposed: { print("2) disposed") }
            )
            .disposed(by: disposeBag)
    }
    
    private static func empty() {
        let disposeBag = DisposeBag()
        
        Observable<Void>.empty().subscribe(
            onNext: { print("\($0)") },
            onError: { print("\($0)") },
            onCompleted: { print("completed") },
            onDisposed: { print("disposed") }
            )
            .disposed(by: disposeBag)
    }
}
