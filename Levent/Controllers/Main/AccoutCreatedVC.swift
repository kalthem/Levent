//
//  AccoutCreatedVC.swift
//  Levent
//
//  Created by Fatema Albaqali on 16/12/2024.
//

import UIKit

class AccoutCreatedVC: UIViewController {
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        let signinVC: SigninVC = SigninVC.instantiate(appStoryboard: .main)
        // Reset the navigation stack with SigninVC as the root
        self.navigationController?.setViewControllers([signinVC], animated: true)
    }
}
