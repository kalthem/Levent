//
//  EditOrganizerVC.swift
//  Levent
//
//   Created by Yusuf M on 9/12/2024.
//

import UIKit
class EditOrganizerVC: UIViewController {
    
    var organizerDetails: OrganizerModel?
    
    @IBOutlet weak var organizerNameTextField: CustomTextField!
    @IBOutlet weak var organizerEmailTextField: CustomTextField!
    @IBOutlet weak var organizerPhoneNumberTextField: CustomTextField!
    @IBOutlet weak var organizerPasswordTextField: CustomTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialData()
        navigationItem.hidesBackButton = true
        
    }
    
    @IBAction func editOrganizerButtonPressed(_ sender: Any) {
        doEditOrganizer()
    }
    
    private func setupInitialData() {
        guard let organizer = organizerDetails else { return }
        organizerNameTextField.text = organizer.name
        organizerEmailTextField.text = organizer.email
        organizerPhoneNumberTextField.text = organizer.contact
        organizerPasswordTextField.text = organizer.password
        organizerEmailTextField.isEnabled = false // Make email non-editable
    }
    
}

extension EditOrganizerVC {
    func doEditOrganizer(){
        guard let organizer = organizerDetails else { return }
                
                let updatedName = organizerNameTextField.text ?? ""
                let updatedContact = organizerPhoneNumberTextField.text ?? ""
                let updatedPassword = organizerPasswordTextField.text ?? ""
                
                if updatedName == organizer.name &&
                    updatedContact == organizer.contact &&
                    updatedPassword == organizer.password {
                    showAlert(message: "No changes detected.")
                    return
                }
                
                // Ask for confirmation
                showConfirmationAlert(
                    title: "Edit Organizer",
                    message: "Are you sure you want to edit the organizer details?",
                    confirmTitle: "Yes",
                    cancelTitle: "No"
                ) { [weak self] in
                    guard let self = self else { return }
                    
                    // Update organizer details
                    let updatedOrganizer = OrganizerModel(
                        name: updatedName,
                        email: organizer.email, // Email remains the same
                        password: updatedPassword,
                        contact: updatedContact,
                        imageURL: organizer.imageURL,
                        savedEvents: organizer.savedEvents
                    )
                    
                    LoaderView.shared.show()
                    AdminFeatures().editOrganizer(organizerEmail: organizer.email, updatedOrganizer: updatedOrganizer) { error in
                        LoaderView.shared.hide()
                        if let error = error {
                            self.showAlert(message: "Failed to edit organizer: \(error.localizedDescription)")
                        } else {
                            self.showAlert(message: "Organizer Profile updated successfully!") {
                                let storyboard = UIStoryboard(name: "Admin", bundle: nil)
                                if let adminViewController = storyboard.instantiateViewController(withIdentifier: "AdminTabBarVC") as? UITabBarController {
                                    self.navigationController?.setViewControllers([adminViewController], animated: true) }
                                return
                            }
                        }
                    }
                }
    }
}
