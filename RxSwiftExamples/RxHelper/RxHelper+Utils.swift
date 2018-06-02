//

import RxSwift
import RxCocoa

extension RxHelper {
    
    static func example(title: String, action: () -> Void) {
        print("===================")
        print("Example: \(title)")
        action()
    }
    
    static func logResourses() {
        print("===================")
        print("RxSwift.Resources.total = \(RxSwift.Resources.total)")
    }
    
    static func randomIntObservable(withDetay delay: Double = 1.0) -> Observable<Int> {
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
    
    static func timerObservable(interval: TimeInterval, count: Int, queue: DispatchQueue) -> Observable<Int> {
        return Observable.create { observer in
            let timer = DispatchSource.makeTimerSource(queue: queue)
            timer.scheduleRepeating(deadline: DispatchTime.now(), interval: interval)
            
            let cancel = Disposables.create {
                timer.cancel()
            }
            
            var next = 1
            timer.setEventHandler {
                if cancel.isDisposed {
                    return
                }
                if next <= count {
                    observer.on(.next(next))
                    next += 1
                } else {
                    observer.onCompleted()
                }
                
            }
            timer.resume()
            
            return cancel
        }
    }
}
