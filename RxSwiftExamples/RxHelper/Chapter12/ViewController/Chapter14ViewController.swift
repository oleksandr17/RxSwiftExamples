//

import UIKit
import RxSwift
import RxCocoa

class Chapter14ViewController: UIViewController {
    
    let bag = DisposeBag()
    
    private var _view: Chapter14View {
        return view as! Chapter14View
    }
    
    // MARK: - View 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _view.textField.rx.text
            .throttle(1.0, scheduler: MainScheduler.instance)
            .map { value in
                return (value ?? "").uppercased()
            }
            .asDriver(onErrorJustReturn: "error occured")
            .drive(_view.label.rx.text)
            .disposed(by: bag)
        
        _view.textField.rx.controlEvent(.editingDidEndOnExit).asObservable()
            .subscribe { (event) in
                print("Text field event: \(event)")
            }
            .disposed(by: bag)
    }
}
