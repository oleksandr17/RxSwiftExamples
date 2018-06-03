//

import UIKit

class Chapter14View: UIView {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.numberOfLines = 0
    }
}
