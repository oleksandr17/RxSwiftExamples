//

import RxSwift
import RxCocoa

extension RxHelper {
    
    static func runNoChapter() {
//        example(title: "coldObservableWithSeveralObservers", action: coldObservableWithSeveralObservers)
    }
    
    private static func coldObservableWithSeveralObservers() {
        let disposeBag = DisposeBag()
        
        let observable = randomIntObservable()
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
