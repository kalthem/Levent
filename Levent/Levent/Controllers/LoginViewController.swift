import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordVisibilityButton: UIButton!

    private var isPasswordVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .leventBeige

        // Configure password visibility button
        passwordVisibilityButton.setImage(UIImage(systemName: "eye"), for: .normal)
        passwordVisibilityButton.tintColor = .leventBlue
    }

    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye.slash" : "eye"
        passwordVisibilityButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Email and password are required.")
            return
        }

        let users = DataStorage.shared.load([User].self, from: "users.json")

        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            if user.isOrganizer {
                navigateToStoryboard(named:"OrganizerHome")

            } else {
                navigateToStoryboard(named:"UserHome")

            }
        } else {
            showAlert(title: "Error", message: "Invalid email or password.")
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        navigateToStoryboard(named:"Register")
    }
}
