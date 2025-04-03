//
//  CardTabBar.swift
//  PTR
//
//  Created by Hussein AlRyalat on 8/30/19.
//  Copyright © 2019 SketchMe. All rights reserved.
//

import UIKit

protocol CardTabBarDelegate: AnyObject {
    func cardTabBar(_ sender: PTCardTabBar, didSelectItemAt index: Int)
}

open class PTCardTabBar: UIView {
    
    weak var delegate: CardTabBarDelegate?
    
    var items: [UITabBarItem] = [] {
        didSet {
            reloadViews()
        }
    }
    
    override open func tintColorDidChange() {
        super.tintColorDidChange()
        reloadApperance()
    }
    
    func reloadApperance(){
        
        buttons().forEach { button in
            button.selectedColor = tintColor
        }
        
        indicatorView.tintColor = tintColor
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        return stackView
    }()
    
    
    lazy var indicatorView: PTIndicatorView = {
        let view = PTIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.constraint(width: 32)
        view.constraint(height: 2)
        view.backgroundColor = tintColor
        //view.makeWidthEqualHeight()
        
        return view
    }()
    lazy var indicatorViewT: PTIndicatorView = {
        let view = PTIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.constraint(width: 32)
        view.constraint(height: 2)
        view.backgroundColor = tintColor
        //view.makeWidthEqualHeight()
        
        return view
    }()
   
    
    private var indicatorViewYConstraint: NSLayoutConstraint!
    private var indicatorViewXConstraint: NSLayoutConstraint!
    
    private var indicatorViewTYConstraint: NSLayoutConstraint!
    private var indicatorViewTXConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
        stackView.arrangedSubviews.forEach {
            if let button = $0 as? UIControl {
                button.removeTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            }
        }
    }
    
    private func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(indicatorView)
        addSubview(indicatorViewT)
        self.backgroundColor = .white
        
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 5)
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 1
        
        indicatorViewYConstraint?.isActive = false
        indicatorViewTYConstraint?.isActive = false
       
        tintColorDidChange()
    }
    
    func add(item: UITabBarItem){
        self.items.append(item)
        self.addButton(with: item.image!)
    }
    
    func remove(item: UITabBarItem){
        if let index = self.items.firstIndex(of: item) {
            self.items.remove(at: index)
            let view = self.stackView.arrangedSubviews[index]
            self.stackView.removeArrangedSubview(view)
        }
    }
    
    private func addButton(with image: UIImage){
        let button = PTBarButton(image: image)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.selectedColor = tintColor
        
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        self.stackView.addArrangedSubview(button)
    }
    
    func select(at index: Int, notifyDelegate: Bool = true){
        for (bIndex, view) in stackView.arrangedSubviews.enumerated() {
            if let button = view as? UIButton {
                button.tintColor =  bIndex == index ? tintColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
        
        if notifyDelegate {
            self.delegate?.cardTabBar(self, didSelectItemAt: index)
        }
    }
    
    
    func reloadViews(){
        indicatorViewYConstraint?.isActive = false
        indicatorViewTYConstraint?.isActive = false
        indicatorViewYConstraint = indicatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -2)
        indicatorViewTYConstraint = indicatorViewT.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: 2)
        indicatorViewTYConstraint.isActive = true
        indicatorViewYConstraint.isActive = true
        
        
        for button in (stackView.arrangedSubviews.compactMap { $0 as? PTBarButton }) {
            stackView.removeArrangedSubview(button)
            button.removeFromSuperview()
            button.removeTarget(self, action: nil, for: .touchUpInside)
        }
        
        for item in items {
            if let image = item.image {
                addButton(with: image)
            } else {
                addButton(with: UIImage())
            }
        }
        
        select(at: 0)
    }
    
    
    
    private func buttons() -> [PTBarButton] {
        return stackView.arrangedSubviews.compactMap { $0 as? PTBarButton }
    }
    
    func select(at index: Int){
        /* move the indicator view */
        if indicatorViewXConstraint != nil,indicatorViewTXConstraint != nil {
            indicatorViewXConstraint.isActive = false
            indicatorViewXConstraint = nil
            indicatorViewTXConstraint.isActive = false
            indicatorViewTXConstraint = nil
        }
        
        for (bIndex, button) in buttons().enumerated() {
            button.selectedColor = tintColor
            button.isSelected = bIndex == index
            
            if bIndex == index {
                indicatorViewXConstraint = indicatorView.centerXAnchor.constraint(equalTo: button.centerXAnchor)
                indicatorViewXConstraint.isActive = true
                indicatorViewTXConstraint = indicatorViewT.centerXAnchor.constraint(equalTo: button.centerXAnchor)
                indicatorViewTXConstraint.isActive = true
            }
        }
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
        
        
        self.delegate?.cardTabBar(self, didSelectItemAt: index)
    }
    
    
    @objc func buttonTapped(sender: PTBarButton){
        if let index = stackView.arrangedSubviews.firstIndex(of: sender){
            select(at: index)
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let position = touches.first?.location(in: self) else {
            super.touchesEnded(touches, with: event)
            return
        }
        
        let buttons = self.stackView.arrangedSubviews.compactMap { $0 as? PTBarButton }.filter { !$0.isHidden }
        let distances = buttons.map { $0.center.distance(to: position) }
        
        let buttonsDistances = zip(buttons, distances)
        
        if let closestButton = buttonsDistances.min(by: { $0.1 < $1.1 }) {
            buttonTapped(sender: closestButton.0)
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0
                                                        , right: 0))
        layer.cornerRadius = 5
    }
}
