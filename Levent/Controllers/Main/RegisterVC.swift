import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterVC: UIViewController {
    
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func singupButtonPressed(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "Please enter your name.")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }
        
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter your password.")
            return
        }
        
        guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(message: "Please confirm your password.")
            return
        }
        
        if password != confirmPassword {
            showAlert(message: "Passwords do not match.")
            return
        }
        
        LoaderView.shared.show()
        let userFeatures = UserFeatures()
        let newUser = UserModel(name: name, email: email, password: password, isVerified: false, profileImage: "", gender: "", birthday: "", interests: [])
        userFeatures.createUser(user: newUser) { [weak self] error in
            LoaderView.shared.hide()
            guard let self = self else { return }
            if let error = error {
                // Show an alert for the error
                self.showAlert(title: "Error", message: "Failed to add user: \(error.localizedDescription)")
            } else {
                // Show a success alert
                self.showAlert(title: "Success", message: "User added successfully!"){
                    let accountCreatedVC: AccoutCreatedVC = AccoutCreatedVC.instantiate(appStoryboard: .main)
                    self.navigationController?.pushViewController(accountCreatedVC, animated: true)
                }
            }
        }
    
        
    }
    
    @IBAction func alreadyHaveACountButtonPressed(_ sender: Any) {
        let singinVC: SigninVC = SigninVC.instantiate(appStoryboard: .main)
        self.navigationController?.setViewControllers([singinVC], animated: true)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
