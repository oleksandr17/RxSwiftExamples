//

import RxSwift
import RxCocoa

extension RxHelper {
    
    static func runNoChapter() {
//        example(title: "coldObservableWithSeveralObservers", action: coldObservableWithSeveralObservers)
    }
    
    private static func randomObservable(withDetay delay: Double = 1.0) -> Observable<Int> {
        let observable = Observable<Int>.create { observer in
            let deadlineTime = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                let random_value = Int(arc4random_uniform(100_000))
                observer.onNext(random_value)
                observer.onCompleted()
            }
            return Disposables.create()
        }
        return observable
    }
    
    private static func coldObservableWithSeveralObservers() {
        let disposeBag = DisposeBag()
        
        let observable = randomObservable()
            .map { $0 + 1 } // just for example reasons
            .share() // make sure to emit event once for all observers
        
        observable.subscribe { event in
            print("1) \(event)")
            }
            .disposed(by: disposeBag)
        
        observable.subscribe { event in
            print("2) \(event)")
            }
            .disposed(by: disposeBag)
    }
}
