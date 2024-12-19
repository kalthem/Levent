//
//  LoginViewController.swift
//  Levent
//
//  Created by Mahdi on 16/12/2024.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var createAccountLabel: UILabel!

    private var isPasswordVisible = false // Tracks visibility of the password

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .leventBeige
        
        logoImageView.image = UIImage(named: "Logo")
        appNameLabel.text = "Levent"
        appNameLabel.textColor = .leventBlue

        configureTextField(emailTextField, placeholder: "Email or Phone Number")
        configureTextField(passwordTextField, placeholder: "Password", isSecure: true)

        passwordVisibilityButton.setImage(UIImage(systemName: "eye"), for: .normal)
        passwordVisibilityButton.tintColor = .leventBlue

        signInButton.setTitle("Sign In", for: .normal)
        signInButton.backgroundColor = .leventBlue
        signInButton.setTitleColor(.leventWhite, for: .normal)
        signInButton.layer.cornerRadius = 8
        signInButton.layer.masksToBounds = true

        let forgotPasswordTap = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped))
        forgotPasswordLabel.isUserInteractionEnabled = true
        forgotPasswordLabel.addGestureRecognizer(forgotPasswordTap)
        forgotPasswordLabel.textColor = .leventBlue
        forgotPasswordLabel.text = "Forgot Your Password?"

        let createAccountTap = UITapGestureRecognizer(target: self, action: #selector(createAccountTapped))
        createAccountLabel.isUserInteractionEnabled = true
        createAccountLabel.addGestureRecognizer(createAccountTap)
        createAccountLabel.textColor = .leventBlue
        createAccountLabel.text = "Create an account"
    }

    private func configureTextField(_ textField: UITextField, placeholder: String, isSecure: Bool = false) {
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
    }

    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        let buttonImageName = isPasswordVisible ? "eye.slash" : "eye"
        passwordVisibilityButton.setImage(UIImage(systemName: buttonImageName), for: .normal)
    }

    @objc private func createAccountTapped() {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        if let registerVC = storyboard.instantiateInitialViewController() {
            navigationController?.pushViewController(registerVC, animated: true)
        }
    }

    @objc private func forgotPasswordTapped() {
        print("Forgot Password tapped")
    }

    @IBAction func signInTapped(_ sender: UIButton) {
        print("Sign In button tapped")
    }
}
