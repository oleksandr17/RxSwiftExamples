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
            }
            .disposed(by: bag)
        
        locationManager.rx.didUpdateLocations
            .subscribe { (event) in
                print("Location: \(event)")
            }
            .disposed(by: bag)
    }}
