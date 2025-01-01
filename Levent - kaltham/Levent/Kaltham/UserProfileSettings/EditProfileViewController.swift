//
//  SettingsViewController.swift
//  Levent
//
//  Created by k 3 on 19/12/2024.
//

import UIKit

class EditProfileViewController: UITableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserProfile()
    }
    
    private func loadUserProfile() {
        if let user = JSONStorage.shared.loadUser() {
            //                user = loadedUser
            nameTextField?.text = user.name
            phoneNumberTextField?.text = user.phoneNumber
            emailTextField?.text = user.email
            genderTextField?.text = user.gender?.rawValue
            if let birthday = user.birthday {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                birthdayTextField?.text = formatter.string(from: birthday)
            }
        }
    }
    
    
    
    // Implement the delegate method
    func didSelectGender(gender: Gender) {
        genderTextField.text = gender.rawValue
        
        // Update the user data
        var user = JSONStorage.shared.loadUser() ?? User(name: "", phoneNumber: "", email: "", password: "", gender: nil)
        user.gender = gender
        JSONStorage.shared.saveUser(user)
    }
        
        @IBAction func unwindToEditProfile(_ unwindSegue: UIStoryboardSegue) {
            loadUserProfile()
          if unwindSegue.identifier == "unwindToEditProfile" {
                loadUserProfile()
            }
            
        }
  //  }
    
}
