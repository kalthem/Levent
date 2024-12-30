

import Foundation
import UIKit
enum AppStoryboard: String {
    case main = "Main"
    case accountSetup = "AccountSetup"
    case user = "UserScreens"
    case tickets = "Tickets"
    case admin = "Admin"
    case organizer = "Organizer"
    
    case help = "Help"
    case newIntake = "New Intake"
}

extension UIViewController{

    class func instantiate<T: UIViewController>(appStoryboard: AppStoryboard) -> T {

        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    func joinStrings(_ strings: String...) -> String {
        return strings.joined(separator: " ")
    }
    
    
    func showAlert(title: String = "Alert", message: String, buttonTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            // Call the completion handler if provided
            completion?()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func showConfirmationAlert(
        title: String = "Confirmation",
        message: String,
        confirmTitle: String,
        cancelTitle: String = "Cancel",
        onConfirm: @escaping () -> Void
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Confirmation button
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            onConfirm()
        }
        alertController.addAction(confirmAction)
        
        // Cancel button
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }

}
