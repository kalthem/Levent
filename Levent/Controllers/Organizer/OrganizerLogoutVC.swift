

import UIKit
class OrganizerLogoutVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        self.showConfirmationAlert(
            title: "Logout",
            message: "Are you sure you want to log out?",
            confirmTitle: "Logout",
            cancelTitle: "Cancel"
        ) { [weak self] in
            // If the user confirms logout
            self?.performLogout()
        }
    }
    
    private func performLogout() {
        // Clear any session data if needed
        UserSessionManager.shared.clearLoggedInUserSession() // Assuming this method exists to clear user session

        let singinVC: SigninVC = SigninVC.instantiate(appStoryboard: .main)
        self.navigationController?.setViewControllers([singinVC], animated: true)
    }
}
