//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        RxHelper.run(window: window!)
        if window!.rootViewController == nil {
            window!.rootViewController = UIViewController()
        }
        window?.makeKeyAndVisible()
        return true
    }
}
