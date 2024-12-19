//
//  SettingsViewController.swift
//  Levent
//
//  Created by k 3 on 19/12/2024.
//

import UIKit

class SettingsViewController: UITableViewController {
    @IBOutlet weak var nameTextField: UITextField!
        @IBOutlet weak var phoneNumberTextField: UITextField!
        @IBOutlet weak var emailTextField: UITextField!

    var userService = UserService()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         print("View did load.")
         
         // Check if user exists, if not, create a mock user
         if userService.loadUser() == nil {
             userService.createMockUser()
         }
         
         loadUserData()// Load user data
     }
     
     func loadUserData() {
         print("Loading user data...")
         
         if let user = userService.loadUser() {
             print("User loaded: \(user)")
             nameTextField?.text = user.name
             phoneNumberTextField?.text = user.phoneNumber
             emailTextField?.text = user.email
         } else {
             print("No user data found.")
         }
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
                self.performLogout()
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
    }
    

