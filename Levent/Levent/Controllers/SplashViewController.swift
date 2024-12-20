import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSplashScreen()
    }

    private func setupSplashScreen() {
        view.backgroundColor = .leventBeige
        // Simulate a delay for splash screen display
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.redirectUser()
        }
    }

    private func redirectUser() {
        if let _ = DataStorage.shared.getCurrentUser() {
            // User is logged in, navigate to UserHome
            let storyboard = UIStoryboard(name: "UserHome", bundle: nil)
            if let userHomeVC = storyboard.instantiateInitialViewController() {
                self.navigateToViewController(viewController: userHomeVC, withNavigation: true)
            }
        } else {
            // User is not logged in, navigate to Welcome
            let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
            if let welcomeVC = storyboard.instantiateInitialViewController() {
                self.navigateToViewController(viewController: welcomeVC, withNavigation: false)
            }
        }
    }

    private func navigateToViewController(viewController: UIViewController, withNavigation: Bool) {
        if withNavigation {
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        } else {
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
