//
//  userProfileVC.swift
//  Levent
//
//  Created by Fatema Albaqali on 20/12/2024.
//

import UIKit
class UserProfileVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
    }
    
    
    @IBAction func editProfileButtonPressed(_ sender: Any) {
        let editProfileVC: EditProfileVC = EditProfileVC.instantiate(appStoryboard: .user)
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    @IBAction func notificationsButtonPressed(_ sender: Any) {
        let userNotifications: NotificationVC = NotificationVC.instantiate(appStoryboard: .user)
        navigationController?.pushViewController(userNotifications, animated: true)
    }
    @IBAction func logoutButtonPressed(_ sender: Any) {
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
        // Clear any session data if needed
        UserSessionManager.shared.clearLoggedInUserSession() // Assuming this method exists to clear user session

        let singinVC: SigninVC = SigninVC.instantiate(appStoryboard: .main)
        self.navigationController?.setViewControllers([singinVC], animated: true)
    }
}
