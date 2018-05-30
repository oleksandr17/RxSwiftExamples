//
//  RxHelper+Chapter7.swift
//  BasicApp
//
//  Created by Oleksandr  on 23/02/2018.
//  Copyright © 2018 Elements Interactive. All rights reserved.
//

import RxSwift
import RxCocoa
import Photos

extension RxHelper {
    
    static func runChapter7() {
        example(title: "toArray", action: toArray)
        example(title: "map", action: map)
        example(title: "mapWithIndex", action: mapWithIndex)
        example(title: "flatMap", action: flatMap)
        example(title: "flatMapLatest", action: flatMapLatest)
    }
    
    private static func toArray() {
        let disposeBag = DisposeBag()
        
        Observable.of("A", "B", "C")
            .toArray()
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func map() {
        let disposeBag = DisposeBag()
        
        Observable.of(1, 2, 3, 4)
            .map {
                return $0 * 2
            }
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func mapWithIndex() {
        let disposeBag = DisposeBag()
        
        Observable.of(1, 2, 3, 4)
            .mapWithIndex { element, index in
                index % 2 == 1 ? element * 2 : element
            }
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func flatMap() {
        struct Student {
            var score: Variable<Int>
        }
        
        let disposeBag = DisposeBag()
        
        let ryan = Student(score: Variable(0))
        let charlotte = Student(score: Variable(100))
        
        let student = PublishSubject<Student>()
        
        student.asObservable()
            .flatMap {
                $0.score.asObservable()
            }
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
        
        student.onNext(ryan)
        student.onNext(charlotte)
        ryan.score.value += 1
        charlotte.score.value += 1
        ryan.score.value += 1
        charlotte.score.value += 1
    }
    
    private static func flatMapLatest() {
        struct Student {
            var score: Variable<Int>
        }
        
        let disposeBag = DisposeBag()
        
        let ryan = Student(score: Variable(0))
        let charlotte = Student(score: Variable(100))
        
        let student = PublishSubject<Student>()
        
        student.asObservable()
            .flatMapLatest {
                $0.score.asObservable()
            }
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
        
        student.onNext(ryan)
        student.onNext(charlotte)
        ryan.score.value += 1
        charlotte.score.value += 1
        ryan.score.value += 1
        charlotte.score.value += 1
    }
}
