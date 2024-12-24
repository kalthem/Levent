//
//  UserService.swift
//  Levent
//
//  Created by k 3 on 19/12/2024.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        showLogoutAlert()
    }
    
    func showLogoutAlert() {
        // Create the alert controller
        let alert = UIAlertController(title: "Confirm Logout",
                                      message: "Are you sure you want to logout?",
                                      preferredStyle: .alert)
        
        // Add Cancel button with blue style
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            // Optionally handle cancel action
        }
        cancelAction.setValue(UIColor.blue, forKey: "titleTextColor") // Set text color to blue
        alert.addAction(cancelAction)
        
        // Add Logout button with red style
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
           // self.performLogout()
            self.dismiss(animated: true, completion: nil)
        }
        logoutAction.setValue(UIColor.red, forKey: "titleTextColor") // Set text color to red
        alert.addAction(logoutAction)
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func performLogout() {
        // Handle the logout logic here (e.g., clear user data, navigate to login screen)
        print("User logged out")
        
     
        }
    
    @IBAction func unwindToSettings(_ unwindSegue: UIStoryboardSegue) {
      
        
    }
        
}
