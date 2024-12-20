//
//  InterestsViewController.swift
//  Levent
//
//  Created by Mahdi
//

import UIKit

class InterestsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var continueButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .leventBeige
        
        // Style the segmented controls
        genderSegmentedControl.tintColor = .leventBlue
        categorySegmentedControl.tintColor = .leventBlue
        
        // Style the continue button
        continueButton.layer.cornerRadius = 8
        continueButton.backgroundColor = .leventBlue
        continueButton.setTitleColor(.leventWhite, for: .normal)
    }

    // MARK: - Actions
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        // Get selected gender
        let gender: String
        switch genderSegmentedControl.selectedSegmentIndex {
        case 0: gender = "Male"
        case 1: gender = "Female"
        default: gender = "Rather Not Say"
        }
        
        // Get selected category
        let selectedCategory: String
        switch categorySegmentedControl.selectedSegmentIndex {
        case 0: selectedCategory = "Concerts"
        case 1: selectedCategory = "Arts"
        default: selectedCategory = "All"
        }
        
        // Save interests to user model (if user exists during registration)
        guard var user = DataStorage.shared.getCurrentUser() else {
            showAlert(title: "Error", message: "No current user available.")
            return
        }
        user.gender = gender
        user.interests = [selectedCategory]
        DataStorage.shared.setCurrentUser(user)

        // Navigate to "Account Created Successfully" screen
        navigateToStoryboard(named:"AccountCreated")
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
