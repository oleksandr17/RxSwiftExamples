//

import RxSwift
import RxCocoa

extension RxHelper {
    
    static func runChapter11() {
//        example(title: "replay", action: replay)
//        example(title: "replayAll", action: replayAll)
//        example(title: "buffer", action: buffer)
//        example(title: "window", action: window)
//        example(title: "delaySubscription", action: delaySubscription)
//        example(title: "delay", action: delay)
//        example(title: "interval", action: interval)
//        example(title: "timer", action: timer)
        example(title: "timeout", action: timeout)
    }
    
    private static func timerObservable(interval: TimeInterval, count: Int, queue: DispatchQueue) -> Observable<Int> {
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
    
    private static func replay() {
        let sourceObservable = timerObservable(interval: 1, count: 5, queue: .main)
            .replay(2)
        _ = sourceObservable.connect()
        
        _ = sourceObservable
            .subscribe { (event) in
                print("1) \(event)")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            _ = sourceObservable
                .subscribe { (event) in
                    print("2) \(event)")
            }
        }
    }
    
    private static func replayAll() {
        let sourceObservable = timerObservable(interval: 1, count: 5, queue: .main)
            .replayAll()
        _ = sourceObservable.connect()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            _ = sourceObservable
                .subscribe { (event) in
                    print(event)
            }
        }
    }
    
    private static func buffer() {
        let sourceObservable = PublishSubject<String>()
        _ = sourceObservable
            .buffer(timeSpan: 2, count: 2, scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sourceObservable.onNext("1")
            sourceObservable.onNext("2")
            sourceObservable.onNext("3")
        }
    }
    
    private static func window() {
        let sourceObservable = PublishSubject<String>()
        _ = sourceObservable
            .window(timeSpan: 2, count: 2, scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sourceObservable.onNext("1")
            sourceObservable.onNext("2")
            sourceObservable.onNext("3")
        }
    }
    
    private static func delaySubscription() {
        // Turn cold observable into hot and start emitting events
        let sourceObservable = timerObservable(interval: 1, count: 5, queue: .main)
            .share()
        _ = sourceObservable.subscribe { (_) in }
        
        // Subscribe to observable but delay event
        _ = sourceObservable
            .delaySubscription(RxTimeInterval(2), scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
        }
    }
    
    private static func delay() {
        let sourceObservable = timerObservable(interval: 1, count: 5, queue: .main)
        _ = sourceObservable
            .delay(RxTimeInterval(2), scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
        }
    }
    
    private static func interval() {
        _ = Observable<Int>.interval(RxTimeInterval(1), scheduler: MainScheduler.instance)
            .subscribe({ event in
                print(event)
            })
    }
    
    private static func timer() {
        _ = Observable<Int>.timer(2, scheduler: MainScheduler.instance)
            .subscribe({ event in
                print(event)
            })
    }
    
    private static func timeout() {
        let sourceObservable = PublishSubject<String>()
        _ = sourceObservable
            .timeout(2, scheduler: MainScheduler.instance)
            .subscribe({ event in
                print(event)
            })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            sourceObservable.onNext("postpone timeout once")
        }
    }
}
