//
//  RxHelper+Chapter6.swift
//  BasicApp
//
//  Created by Oleksandr  on 23/02/2018.
//  Copyright © 2018 Elements Interactive. All rights reserved.
//

import RxSwift
import RxCocoa
import Photos

extension RxHelper {
    
    static func runChapter6() {
        example(title: "share", action: share)
        example(title: "ignoreElements", action: ignoreElements)
        example(title: "throttle", action: throttle)
        example(title: "take", action: take)
//        example(title: "photosAuthorised", action: photosAuthorised)
    }
    
    private static func share() {
        let disposeBag = DisposeBag()
        
        let observable = Observable<Int>.create { observer in
            let start = Int(arc4random_uniform(100_000))
            observer.onNext(start)
            observer.onNext(start+1)
            observer.onNext(start+2)
            observer.onCompleted()
            return Disposables.create()
        }
        
        observable
            .subscribe { event in
                print("1) \(event)")
            }
            .disposed(by: disposeBag)
        
        observable
            .subscribe { event in
                print("2) \(event)")
            }
            .disposed(by: disposeBag)
        
        // Share doesn't work because first subscription is completed before second even starts
        observable.share()
            .subscribe { event in
                print("share 1) \(event)")
            }
            .disposed(by: disposeBag)
        
        observable.share()
            .subscribe { event in
                print("share 2) \(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func ignoreElements() {
        let disposeBag = DisposeBag()
        
        Observable<Int>.create { observer in
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
//            observer.onCompleted()
            observer.onError(RxError.defaultError)
            return Disposables.create()
            }
            .ignoreElements()
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func throttle() {
        let disposeBag = DisposeBag()
        
        Observable<Int>.create { observer in
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onCompleted()
            return Disposables.create()
            }
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func take() {
        let disposeBag = DisposeBag()
        
        Observable<Int>.create { observer in
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onCompleted()
            return Disposables.create()
            }
            .take(5.0, scheduler: MainScheduler.instance)
            .subscribe { event in
                print("\(event)")
            }
            .disposed(by: disposeBag)
    }
    
    private static func photosAuthorised() {
        // This example makes sure that UI is updated once user grants access to photo library.
        // Any immediate measurements of Rx resources will tell about memory leaks. It happens because an `observer` is hold by `DispatchQueue.main`.
        let disposeBag = DisposeBag()
        
        Observable<Bool>.create { observer in
            DispatchQueue.main.async {
                if PHPhotoLibrary.authorizationStatus() == .authorized {
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    observer.onNext(false)
                    PHPhotoLibrary.requestAuthorization { newStatus in
                        observer.onNext(newStatus == .authorized)
                        observer.onCompleted()
                    }
                } }
            return Disposables.create()
            }
            .share()
            .skipWhile { $0 == false }
            .take(1)
            .subscribe(onNext: { granted in
                DispatchQueue.main.async {
                    print("Photo library access: \(granted)")
                }
            })
            .disposed(by: disposeBag)
    }
}
