//

import RxSwift
import RxCocoa

extension RxHelper {
    
    private static let globalScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    
    static func runChapter15() {
        example(title: "subscribeOn", action: subscribeOn)
//        example(title: "observeOn", action: observeOn)
    }
    
    private static func subscribeOn() {
        let source = Observable<String>.create { observer in
            logThread()
            observer.onNext("[apple]")
            observer.onNext("[pineapple]")
            observer.onNext("[strawberry]")
            observer.onCompleted()
            return Disposables.create()
        }
        
        _ = source
            .subscribeOn(globalScheduler)
            .subscribe { event in
                logThread()
                print("\(event)")
            }
    }
    
    private static func observeOn() {
        let source = Observable<String>.create { observer in
            logThread()
            observer.onNext("[apple]")
            observer.onNext("[pineapple]")
            observer.onNext("[strawberry]")
            observer.onCompleted()
            return Disposables.create()
        }
        
        _ = source
            .subscribeOn(globalScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                logThread()
                print("\(event)")
        }
    }
}
