//
//  MainViewController.swift
//  2nd-assignment
//
//  Created by Hassan Azhar on 02/07/2022.
//

import UIKit

class MainViewController: UIViewController, IconTextButtonDelegate
{  
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var menuTrailingConstraint: NSLayoutConstraint!
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        menuTrailingConstraint.constant = -270
        UIView.animate(withDuration: 0.33){
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func reLoadButton(_ sender: UIButton) {
        menuTrailingConstraint.constant = 0
        UIView.animate(withDuration: 0.33){
            self.view.layoutIfNeeded()
        }
    }
    let list: [IconTextButtonViewModel] = [        IconTextButtonViewModel(text: "Home", imageName: "home", isSubMenu: false),        IconTextButtonViewModel(text: "Cleaning Module", imageName: "cleaning module", isSubMenu: false),
        IconTextButtonViewModel(text: "Inspection Module", imageName: "inspection module", isSubMenu: false),
        IconTextButtonViewModel(text: "Management Module", imageName: "home", isSubMenu: false),
        IconTextButtonViewModel(text: "Management Clean", imageName: "management clean", isSubMenu: true),
        IconTextButtonViewModel(text: "Management Inspect", imageName: "management inspect", isSubMenu: true),
        IconTextButtonViewModel(text: "Management On-The-Spot", imageName: "management ots", isSubMenu: true),
        IconTextButtonViewModel(text: "Quick Scan", imageName: "management quick scan",isSubMenu: true),
        IconTextButtonViewModel(text: "Server Connect", imageName: "server connect icon", isSubMenu: false),
        IconTextButtonViewModel(text: "Logout", imageName: "logout", isSubMenu: false)
    ]
    var buttonsList: [IconTextButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    func setupViews(){
        buttonsList = []
        var prev: IconTextButton!
        for i in 0..<list.count {
            
            let model = list[i]
            
            let iconButton = IconTextButton(frame:CGRect(x: 0, y: 0 , width: 0, height: 0))
            
            iconButton.configure(with: model)
            
            iconButton.delegate = self
            
            buttonsList.append(iconButton)
            
            subView.addSubview(iconButton)
            iconButton.translatesAutoresizingMaskIntoConstraints = false
            
            var leading = 23
            if iconButton.isSubMenu {
                leading = 38
            }
            iconButton.leadingAnchor.constraint(equalTo: subView.leadingAnchor,constant: CGFloat(leading)).isActive = true
            
            iconButton.trailingAnchor.constraint(equalTo: subView.trailingAnchor,constant: 40).isActive = true
            
            iconButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
            
            iconButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
            if prev == nil {
                iconButton.topAnchor.constraint(equalTo: subView.topAnchor, constant: 104).isActive = true
            } else {
                iconButton.topAnchor.constraint(equalTo: prev.safeAreaLayoutGuide.bottomAnchor, constant:CGFloat(9)).isActive = true
            }
            prev = iconButton
            
        }
    }
  
    
    //MARK: - IconTextButtonDelegate
    func btnpressed(selectedButton:IconTextButton) {
        for button in buttonsList {
            if button == selectedButton {
                button.isButtonSelected = true
            } else {
                button.isButtonSelected = false
            }
        }
    }
}

