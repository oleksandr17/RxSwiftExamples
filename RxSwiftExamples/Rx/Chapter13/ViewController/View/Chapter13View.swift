//

import UIKit

class Chapter13View: UIView {

    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicator.hidesWhenStopped = true
        
        label.numberOfLines = 0
        label.text = nil
    }
}
