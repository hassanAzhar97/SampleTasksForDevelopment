

import UIKit

open class PTIndicatorView: UIView {
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 1
    }
    
    override open func tintColorDidChange() {
        super.tintColorDidChange()
        self.backgroundColor = tintColor
    }
}
