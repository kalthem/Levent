//
//  PersonalizeVC.swift
//  Levent
//
//  Created by Fatema Albaqali on 25/12/2024.
//

import UIKit
class PersonalizeVC: UIViewController {
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        let genderSelectVC: GenderSelectVC = GenderSelectVC.instantiate(appStoryboard: .accountSetup)
        self.navigationController?.pushViewController(genderSelectVC, animated: true)
    }
}
