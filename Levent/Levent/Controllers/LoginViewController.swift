//
//  LoginViewController.swift
//  Levent
//
//  Created by Mahdi on 14/12/2024.
//
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let demoEmail = "demo@example.com"
    let demoPassword = "password123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter both email and password")
            return
        }
        
        if email == demoEmail && password == demoPassword {
            showAlert(message: "Login Successful!")
        } else {
            showAlert(message: "Invalid email or password")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
