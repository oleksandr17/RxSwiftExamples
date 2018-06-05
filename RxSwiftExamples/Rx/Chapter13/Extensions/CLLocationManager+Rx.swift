//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class RxCLLocationManagerDelegateProxy: DelegateProxy, CLLocationManagerDelegate, DelegateProxyType {
    
    // MARK: - DelegateProxyType
    
    class func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let locationManager: CLLocationManager = object as! CLLocationManager
        locationManager.delegate = delegate as? CLLocationManagerDelegate
    }
    
    class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let locationManager: CLLocationManager = object as! CLLocationManager
        return locationManager.delegate
    }
}
