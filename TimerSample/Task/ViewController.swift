//
//  ViewController.swift
//  Task
//
//  Created by Hassan Azhar on 16/09/2022.
//

import UIKit

class ViewController: UIViewController{
 
    override func viewDidLoad() {
        super.viewDidLoad()
        observeTimeout()
    }
}
extension UIViewController {
    func observeTimeout() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTimeout),
            name: .appTimeout,
            object: nil
        )
        
    }

    @objc func handleTimeout() {
        let alert = UIAlertController(title: "Timeout", message: "User LogOut!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
        }))
        present(alert, animated: true, completion: nil)
        view.backgroundColor = .systemTeal
    }
}
