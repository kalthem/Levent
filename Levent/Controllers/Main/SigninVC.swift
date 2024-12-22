import UIKit
import FirebaseAuth
import FirebaseFirestore

class SigninVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signinButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter your password.")
            return
        }
        if email == "admin" && password == "admin"{
            let storyboard = UIStoryboard(name: "Admin", bundle: nil)
            if let adminViewController = storyboard.instantiateViewController(withIdentifier: "AdminTabBarVC") as? UITabBarController {
                self.navigationController?.setViewControllers([adminViewController], animated: true) }
            return
        }
        // Show loader
        LoaderView.shared.show()
        

        let authFeatures = AuthFeatures()
        
        authFeatures.signIn(email: email, password: password) { role, isVerified, name, interests, error in
            LoaderView.shared.hide()
            
            if let error = error {
                print("Sign-in failed: \(error.localizedDescription)")
                self.showAlert(message: "Sign-in failed: \(error.localizedDescription)")
            } else if let role = role, let isVerified = isVerified, let name = name {
                // Save the logged-in user's details
                UserSessionManager.shared.setLoggedInUser(email: email, role: role, name: name, userInterests: interests ?? [])
                print("Welcome, \(name)!") // Print the user's name

                if role == "organizer" {
                    // Navigate to Organizer TabBar
                    let storyboard = UIStoryboard(name: "Organizer", bundle: nil)
                    if let homeViewController = storyboard.instantiateViewController(withIdentifier: "OrganizerTabBarVC") as? UITabBarController {
                        self.navigationController?.setViewControllers([homeViewController], animated: true)
                    }
                } else {
                    if isVerified {
                        // Navigate to User Home TabBar
                        let storyboard = UIStoryboard(name: "UserScreens", bundle: nil)
                        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeVCTabBar") as? UITabBarController {
                            self.navigationController?.setViewControllers([homeViewController], animated: true)
                        }
                    } else {
                        // Navigate to PersonalizeVC if not verified
                        let personalizeVC = PersonalizeVC.instantiate(appStoryboard: .accountSetup)
                        self.navigationController?.setViewControllers([personalizeVC], animated: true)
                    }
                }
            }
        }

    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        let registerVC = RegisterVC.instantiate(appStoryboard: .main)
        self.navigationController?.setViewControllers([registerVC], animated: true)
    }
    
    // Function to show alert
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
