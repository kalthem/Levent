//
//  RegisterViewController.swift
//  Levent
//
//  Created by Mahdi on 16/12/2024.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
//    @IBOutlet weak var appTitleLabel: UILabel!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var confirmPasswordVisibilityButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
//    @IBOutlet weak var alreadyHaveAccountLabel: UILabel!
    
    private var isPasswordVisible = false
    private var isConfirmPasswordVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .leventBeige

        // Logo
        logoImageView.image = UIImage(named: "Logo")
//        appTitleLabel.text = "Levent"

        // Configure text fields
        configureTextField(nameTextField, placeholder: "Name")
        configureTextField(emailTextField, placeholder: "Email")
        configureTextField(passwordTextField, placeholder: "Password", isSecure: true)
        configureTextField(confirmPasswordTextField, placeholder: "Confirm Password", isSecure: true)

        // Configure password visibility buttons
        setupPasswordVisibilityButton(passwordVisibilityButton)
        setupPasswordVisibilityButton(confirmPasswordVisibilityButton)

        // Register button
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .leventBlue
        registerButton.setTitleColor(.leventWhite, for: .normal)
        registerButton.layer.cornerRadius = 8
        registerButton.layer.masksToBounds = true

        // Clickable "Already have an account?" label
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToLogin))
//        alreadyHaveAccountLabel.isUserInteractionEnabled = true
//        alreadyHaveAccountLabel.addGestureRecognizer(tapGesture)
//        alreadyHaveAccountLabel.textColor = .leventBlue
//        alreadyHaveAccountLabel.text = "Already have an account?"
    }

    private func configureTextField(_ textField: UITextField, placeholder: String, isSecure: Bool = false) {
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    }

    private func setupPasswordVisibilityButton(_ button: UIButton) {
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .leventBlue
    }

    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        if sender == passwordVisibilityButton {
            isPasswordVisible.toggle()
            passwordTextField.isSecureTextEntry = !isPasswordVisible
            updatePasswordVisibilityButton(button: passwordVisibilityButton, isVisible: isPasswordVisible)
        } else if sender == confirmPasswordVisibilityButton {
            isConfirmPasswordVisible.toggle()
            confirmPasswordTextField.isSecureTextEntry = !isConfirmPasswordVisible
            updatePasswordVisibilityButton(button: confirmPasswordVisibilityButton, isVisible: isConfirmPasswordVisible)
        }
    }

    private func updatePasswordVisibilityButton(button: UIButton, isVisible: Bool) {
        let imageName = isVisible ? "eye.slash" : "eye"
        button.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }

        guard password == confirmPassword else {
            showAlert(message: "Passwords do not match.")
            return
        }

        // Registration logic here
        print("Registration successful for \(name) with email \(email).")
    }

    @objc private func navigateToLogin() {
        navigationController?.popViewController(animated: true)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
