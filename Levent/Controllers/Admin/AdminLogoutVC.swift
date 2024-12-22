//
//  AdminLogoutVC.swift
//  Levent
//
//   Created by Yusuf M on 9/12/2024.
//

import UIKit
class AdminLogoutVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func logOutButtonPressed(_ sender: Any) {
        self.showConfirmationAlert(
            title: "Logout",
            message: "Are you sure you want to log out?",
            confirmTitle: "Logout",
            cancelTitle: "Cancel"
        ) { [weak self] in
            // If the user confirms logout
            self?.performLogout()
        }
    }
    
    private func performLogout() {

        let singinVC: SigninVC = SigninVC.instantiate(appStoryboard: .main)
        self.navigationController?.setViewControllers([singinVC], animated: true)
    }
}
