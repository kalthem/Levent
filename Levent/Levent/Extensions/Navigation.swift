import UIKit

extension UIViewController {
    func navigateToStoryboard(named storyboardName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() {
            if let navigationController = self.navigationController {
                // Push onto navigation stack
                navigationController.pushViewController(viewController, animated: true)
            } else {
                // Present modally if no navigation controller
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
        } else {
            print("Error: Could not find initial view controller in storyboard \(storyboardName).")
        }
    }
}
