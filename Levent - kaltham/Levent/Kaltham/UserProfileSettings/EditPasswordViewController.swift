//
//  EditPassword.swift
//  Levent
//
//  Created by k 3 on 27/12/2024.
//

import UIKit

class EditPasswordViewController: UIViewController {
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var continueButtonTapped: UIButton!
    private var isPasswordValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPassword.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        continueButtonTapped.isEnabled = false // Initially disable the button
    }
    
    
    @IBAction func validatePassword(_ sender: Any) {
        validatePassword() // Validate the password
                if isPasswordValid {
                    performSegue(withIdentifier: "toNewPasswordView", sender: self) // Proceed with the segue
                }
    }
    
    private func validatePassword() {
        guard let enteredPassword = currentPassword.text, !enteredPassword.isEmpty else {
                    showAlert(title: "Error", message: "Please enter your current password.")
                    return
                }
                
                if enteredPassword == JSONStorage.shared.loadUser()?.password {
                    isPasswordValid = true
                } else {
                    isPasswordValid = false
                    showAlert(title: "Invalid Password", message: "The current password you entered is incorrect.")
                }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            if identifier == "toNewPasswordView" {
                return isPasswordValid // Allow segue only if valid
            }
            return true // Allow other segues
        
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        continueButtonTapped.isEnabled = (textField.text?.count ?? 0) >= 6
    }
    
    // Action for Forgot Password button tap
      @IBAction func forgotPasswordTapped(_ sender: Any) {
          // Show an alert indicating that a password reset email has been sent
          showAlert(title: "Password Reset", message: "A password reset email has been sent to your registered email address.")
      }
      
    
    // Helper method to show an alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
    

class NewPasswordViewController: UIViewController {
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var doneButtonTapped: UIButton!
    var userPassword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initially disable the Done button
        doneButtonTapped.isEnabled = false
        
        // Add target actions to monitor text field changes
        newPassword.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        confirmPassword.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
    // Method to enable/disable the Done button based on text field changes
    @objc func textFieldsDidChange(_ textField: UITextField) {
        if let newPasswordText = newPassword.text, let confirmPasswordText = confirmPassword.text,
           !newPasswordText.isEmpty, !confirmPasswordText.isEmpty, newPasswordText == confirmPasswordText {
            doneButtonTapped.isEnabled = true
        } else {
            doneButtonTapped.isEnabled = false
        }
    }
    
    // Action for Done button tap
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let newPasswordText = newPassword.text, let confirmPasswordText = confirmPassword.text else {
            return
        }
        
        if newPasswordText == confirmPasswordText {
            // Save the new password
            
            
            userPassword = newPassword.text ?? ""
            if var user = JSONStorage.shared.loadUser() {
                // Update the name
                user.password = userPassword!
                
                // Save the updated user back to storage
                JSONStorage.shared.saveUser(user)
                
            }
        }
        
        
        
        
    }
}
