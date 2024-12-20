//
//  RegisterViewController.swift
//  Levent
//
//  Created by Mahdi
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var organizerSwitch: UISwitch!
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var confirmPasswordVisibilityButton: UIButton!

    private var isPasswordVisible = false
    private var isConfirmPasswordVisible = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .leventBeige
        
        passwordVisibilityButton.setImage(UIImage(systemName: "eye"), for: .normal)
        confirmPasswordVisibilityButton.setImage(UIImage(systemName: "eye"), for: .normal)
    }

    // MARK: - Actions
    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye.slash" : "eye"
        passwordVisibilityButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @IBAction func toggleConfirmPasswordVisibility(_ sender: UIButton) {
        isConfirmPasswordVisible.toggle()
        confirmPasswordTextField.isSecureTextEntry = !isConfirmPasswordVisible
        let imageName = isConfirmPasswordVisible ? "eye.slash" : "eye"
        confirmPasswordVisibilityButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(title: "Error", message: "All fields are required.")
            return
        }

        guard password == confirmPassword else {
            showAlert(title: "Error", message: "Passwords do not match.")
            return
        }

        // Check if user already exists
        var users = DataStorage.shared.load([User].self, from: "users.json")
        if users.contains(where: { $0.email == email }) {
            showAlert(title: "Error", message: "An account with this email already exists.")
            return
        }

        // Create new user
        let newUser = User(id: UUID().uuidString, name: name, email: email, password: password, isOrganizer: organizerSwitch.isOn)
        users.append(newUser)

        // Save updated users
        if DataStorage.shared.save(users, to: "users.json") {
            // Set the new user as the current user
            DataStorage.shared.setCurrentUser(newUser)
            
            // Navigate to the next screen
            if newUser.isOrganizer {
                navigateToStoryboard(named:"OrganizerHome")

            } else {
                navigateToStoryboard(named:"Interests")

            }
        } else {
            showAlert(title: "Error", message: "Failed to create account. Please try again.")
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
