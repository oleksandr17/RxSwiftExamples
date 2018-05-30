//
//  RxHelper+Chapter5.swift
//  BasicApp
//
//  Created by Oleksandr  on 23/02/2018.
//  Copyright © 2018 Elements Interactive. All rights reserved.
//

import RxSwift
import RxCocoa

extension RxHelper {
    
    static func runChapter5() {
        example(title: "ignore", action: ignore)
        example(title: "elementAt", action: elementAt)
        example(title: "skip", action: skip)
        example(title: "skipWhile", action: skipWhile)
        example(title: "filter", action: filter)
        example(title: "skipUntil", action: skipUntil)
        example(title: "take", action: take)
        example(title: "takeWhileWithIndex", action: takeWhileWithIndex)
        example(title: "takeUntil", action: takeUntil)
        example(title: "distinctUntilChanged", action: distinctUntilChanged)
    }
    
    private static func ignore() {
        // Just accept `complete` or `error` events
        let disposeBag = DisposeBag()
        
        let subject = PublishSubject<String>()
        subject
            .ignoreElements()
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
        
        subject.onNext("X")
        subject.onNext("X")
        subject.onNext("X")
        subject.onCompleted()
    }
    
    private static func elementAt() {
        let disposeBag = DisposeBag()
        
        let subject = PublishSubject<String>()
        subject
            .elementAt(2)
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
        
        subject.onNext("0")
        subject.onNext("1")
//        subject.onCompleted()
        subject.onNext("2")
        subject.onNext("3")
        subject.onError(RxError.defaultError) // no impact
    }
    
    private static func skip() {
        let disposeBag = DisposeBag()
        
        Observable.of("A", "B", "C", "D", "E", "F")
            .skip(3)
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func filter() {
        let disposeBag = DisposeBag()
        
        Observable.of(1, 2, 3, 4, 5, 6)
            .filter { element in
                element % 2 == 0
            }
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func skipWhile() {
        let disposeBag = DisposeBag()
        
        Observable.of(2, 2, 3, 4, 4)
            .skipWhile { element in
                element % 2 == 0
            }
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func skipUntil() {
        let disposeBag = DisposeBag()
        
        let subject = PublishSubject<String>()
        let trigger = PublishSubject<String>()
        
        subject
            .skipUntil(trigger)
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
        
        subject.onNext("A")
        subject.onNext("B")
        trigger.onNext("trigger")
        subject.onNext("C")
    }
    
    private static func take() {
        let disposeBag = DisposeBag()
        
        Observable.of(1, 2, 3, 4, 5, 6)
            .take(3)
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func takeWhileWithIndex() {
        let disposeBag = DisposeBag()
        
        Observable.of(2, 2, 4, 4, 6, 6)
            .takeWhileWithIndex { integer, index in
                integer % 2 == 0 && index < 3
            }
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func takeUntil() {
        let disposeBag = DisposeBag()
        
        let subject = PublishSubject<String>()
        let trigger = PublishSubject<String>()
        
        subject
            .takeUntil(trigger)
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
        
        subject.onNext("1")
        trigger.onNext("trigger")
        subject.onNext("2")
    }
    
    private static func distinctUntilChanged() {
        let disposeBag = DisposeBag()
        
        Observable.of("A", "A", "B", "B", "A")
            .distinctUntilChanged()
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
}
