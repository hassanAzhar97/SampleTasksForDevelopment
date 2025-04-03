

import UIKit


public class PTBarButton: UIButton {
    
    var selectedColor: UIColor! = UIColor(red: 0.55, green: 0.706, blue: 1, alpha: 1) {
        didSet {
            reloadApperance()
        }
    }
    
    var unselectedColor: UIColor! = UIColor(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet {
            reloadApperance()
        }
    }
    
    init(forItem item: UITabBarItem) {
        super.init(frame: .zero)
        setImage(item.image, for: .normal)
    }
    
    init(image: UIImage){
        super.init(frame: .zero)
        setImage(image, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override public var isSelected: Bool {
        didSet {
            reloadApperance()
        }
    }
    
    func reloadApperance(){
        self.tintColor = isSelected ? selectedColor : unselectedColor
    }
}
