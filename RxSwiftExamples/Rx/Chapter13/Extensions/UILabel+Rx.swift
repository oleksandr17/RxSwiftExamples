//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UILabel {
    
    var isLoading: Binder<Bool> {
        return Binder(self.base, scheduler: MainScheduler.instance) { target, value in
            target.textColor = value ? .red : .black
        }
    }
}
