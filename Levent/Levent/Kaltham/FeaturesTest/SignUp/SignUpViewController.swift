//
//  SignUpViewController.swift
//  Levent
//
//  Created by k 3 on 12/12/2024.
//

import UIKit

class SignupViewController: UIViewController {
    
    var usernameTextField = UITextField()
    var emailTextField = UITextField()
    var phoneNumberTextField = UITextField()
    var passwordTextField = UITextField()
    let signupButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        
        // Username Label and TextField
        let usernameLabel = UILabel()
        usernameLabel.text = "Username"
        view.addSubview(usernameLabel)
        // Set the frame or use Auto Layout
        usernameTextField.placeholder = "Enter your username"
        view.addSubview(usernameTextField)
        
        // Email Label and TextField
        let emailLabel = UILabel()
        emailLabel.text = "Email"
        view.addSubview(emailLabel)
        emailTextField.placeholder = "Enter your email"
        emailTextField.keyboardType = .emailAddress
        view.addSubview(emailTextField)
        
        // Phone Number Label and TextField
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.text = "Phone Number"
        view.addSubview(phoneNumberLabel)
        phoneNumberTextField.placeholder = "Enter your phone number"
        phoneNumberTextField.keyboardType = .phonePad
        view.addSubview(phoneNumberTextField)
        
        // Password Label and TextField
        let passwordLabel = UILabel()
        passwordLabel.text = "Password"
        view.addSubview(passwordLabel)
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        // Signup Button
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        view.addSubview(signupButton)

        // Layout your views here (using frames or Auto Layout)
    }
    
    @objc private func signupTapped() {
        // Handle signup logic
    }
}
