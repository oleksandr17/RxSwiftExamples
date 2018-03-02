//
//  RxHelper+Chapter3.swift
//  BasicApp
//
//  Created by Oleksandr  on 23/02/2018.
//  Copyright © 2018 Elements Interactive. All rights reserved.
//

import RxSwift
import RxCocoa

extension RxHelper {
    
    static func runChapter3() {
        example(title: "publishSubject", action: publishSubject)
        example(title: "behaviorSubject", action: behaviorSubject)
        example(title: "replaySubject", action: replaySubject)
        example(title: "variable", action: variable)
    }
    
    private static func publishSubject() {
        let disposeBag = DisposeBag()
        
        let subject = PublishSubject<String>()
        
        subject.onNext("Is anyone listening?")
        subject
            .subscribe { event in
                print("1) \(event)")
            }
            .disposed(by: disposeBag)
        subject.on(.next("1"))
        subject.onNext("2")
        
        subject
            .subscribe { event in
                print("2) \(event)")
            }
            .disposed(by: disposeBag)
        subject.onNext("3")
        subject.onCompleted()
        subject.onError(RxError.defaultError) // will never be called
        
        subject
            .subscribe { event in
                print("3) \(event)")
            }
            .disposed(by: disposeBag)
        subject.onNext("4")
    }
    
    private static func behaviorSubject() {
        let disposeBag = DisposeBag()
        
        let subject = BehaviorSubject(value: "Initial value")
        subject
            .subscribe { event in
                print("1) \(event)")
            }
            .disposed(by: disposeBag)
        subject.onNext("1")
        subject
            .subscribe { event in
                print("2) \(event)")
            }
            .disposed(by: disposeBag)
        subject.onNext("2")
    }
    
    private static func replaySubject() {
        let disposeBag = DisposeBag()
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        subject
            .subscribe { event in
                print("1) \(event)")
            }
            .disposed(by: disposeBag)
        subject
            .subscribe { event in
                print("2) \(event)")
            }
            .disposed(by: disposeBag)
        
        subject.onNext("4")
    }
    
    private static func variable() {
        let disposeBag = DisposeBag()
        let variable = Variable("Initial value")
        
        variable.value = "New initial value"
        
        variable.asObservable()
            .subscribe { event in
                print("1) \(event)")
            }
            .disposed(by: disposeBag)
        
        variable.value = "1"
        
        variable.asObservable()
            .subscribe { event in
                print("2) \(event)")
            }
            .disposed(by: disposeBag)
        
        variable.value = "2"
    }
}
