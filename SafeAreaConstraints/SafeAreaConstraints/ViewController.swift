//
//  ViewController.swift
//  SafeAreaConstraints
//
//  Created by Hassan Azhar on 15/07/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    func setupViews(){
        let topLabel = makeLabel(withText: "top")
        let bottomLabel = makeLabel(withText: "bottom")
        let leadingLabel = makeLabel(withText: "leading")
        let trailingLabel = makeLabel(withText: "trailing")
        
        view.addSubview(topLabel)
        view.addSubview(bottomLabel)
        view.addSubview(leadingLabel)
        view.addSubview(trailingLabel)
        //
        
        NSLayoutConstraint.activate([
        topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 8),
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //
        bottomLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -8),
        bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //
        leadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        leadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        //
        trailingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        trailingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    func makeLabel(withText text : String)-> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: 36)
        label.backgroundColor = .systemBrown
        
        return label
    }
    
}

