//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa

class Chapter13ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    let bag = DisposeBag()
    
    private var _view: Chapter13View {
        return view as! Chapter13View
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _view.locationButton.rx.tap
            .subscribe { [weak self] (event) in
                self?.locationManager.requestWhenInUseAuthorization()
                self?.locationManager.startUpdatingLocation()
                self?.observeLocationOnce()
            }
            .disposed(by: bag)
    }
    
    // MARK: - Location
    
    @objc
    private func observeLocationOnce() {
        let location = locationManager.rx.didUpdateLocations
            .take(1)
            .delay(RxTimeInterval(2), scheduler: MainScheduler.instance)
        
        // Contentlet 
        location
            .asDriver(onErrorJustReturn: [])
            .map { locatios -> CLLocation? in
                return locatios.first
            }
            .map { location -> String in
                guard let location = location else {
                    return "Location unknown"
                }
                return "\(location)"
            }
            .drive(_view.label.rx.text)
            .disposed(by: bag)
        
        // Activity indicator
        let activityStop = location
            .map {_ in
                return false
            }
        
        let activityStart = Observable.just(true)
        
        let loading = Observable.of(activityStart, activityStop)
            .merge()
            .asDriver(onErrorJustReturn: false)
            
        loading
            .drive(_view.activityIndicator.rx.isAnimating)
            .disposed(by: bag)
        
        loading
            .drive(_view.label.rx.isLoading)
            .disposed(by: bag)
    }
}
