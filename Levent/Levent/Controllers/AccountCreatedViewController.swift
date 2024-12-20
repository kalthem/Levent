//
//  AccountCreatedViewController.swift
//  Levent
//
//  Created by Mahdi on 20/12/2024.
//

import UIKit

class AccountCreatedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .leventBeige
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let currentUser = DataStorage.shared.getCurrentUser() else {
            showAlert(title: "Error", message: "Failed to identify the current user.")
            return
        }
        
        if currentUser.isOrganizer {
            navigateToPage(storyboardName: "OrganizerHome", viewControllerID: "OrganizerHomeViewController")
        } else {
            navigateToPage(storyboardName: "UserHome", viewControllerID: "UserHomeViewController")
        }
    }

    private func navigateToPage(storyboardName: String, viewControllerID: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID) as? UIViewController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
