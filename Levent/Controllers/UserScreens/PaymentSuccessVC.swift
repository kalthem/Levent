//
//  PaymentSuccessVC.swift
//  Levent
//
//  Created by Fatema Albaqali on 20/12/2024.
//

import UIKit
class PaymentSuccessVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserScreens", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeVCTabBar") as? UITabBarController {
            self.navigationController?.setViewControllers([homeViewController], animated: true)
        }
    }
}
