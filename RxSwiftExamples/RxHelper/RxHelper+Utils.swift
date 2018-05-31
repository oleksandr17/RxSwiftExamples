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
}
