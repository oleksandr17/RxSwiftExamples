//

import RxSwift
import RxCocoa

private struct ViewModel {
    var name = Variable<String?>(nil)
    var surname = Variable<String?>(nil)
    var fullname: Observable<String>
    
    init() {
        fullname = Observable.combineLatest(name.asObservable(), surname.asObservable()) { name, surname in
            return "\(name ?? "_") \(surname ?? "_")"
        }
    }
}

extension RxHelper {

    static func runChapter16() {
        example(title: "viewModel", action: viewModel)
    }
    
    private static func viewModel() {
        let disposeBag = DisposeBag()
        
        let viewModel = ViewModel()
        
        viewModel.name.asObservable()
            .subscribe { event in
                print("Name: \(event)")
            }
            .disposed(by: disposeBag)
        
        viewModel.surname.asObservable()
            .subscribe { event in
                print("Surname: \(event)")
            }
            .disposed(by: disposeBag)
        
        viewModel.fullname.asObservable()
            .subscribe { event in
                print("Fullname: \(event)")
            }
            .disposed(by: disposeBag)
        
        viewModel.name.value = "hello"
        viewModel.surname.value = "world"
    }
}
