//
//  CreateNewOrganizerVC.swift
//  Levent
//
//   Created by Yusuf M on 9/12/2024.
//

import UIKit
class CreateNewOrganizerVC: UIViewController {
    
    
    @IBOutlet weak var nameTextField: CustomTextField!
    
    
    @IBOutlet weak var emailTextField: CustomTextField!
    
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func emptyAllFields(){
        nameTextField.text = ""
        emailTextField.text = ""
        phoneNumberTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    @IBAction func addOrganizerButtonPressed(_ sender: Any) {
        guard let organizerName = nameTextField.text, !organizerName.isEmpty else {
            showAlert(message: "Please enter the event name.")
            return
        }
        
        guard let organizerEmail = emailTextField.text, !organizerEmail.isEmpty else {
            showAlert(message: "Please enter the artist name.")
            return
        }
        
        guard let organizerPhoneNumber = phoneNumberTextField.text, !organizerPhoneNumber.isEmpty else {
            showAlert(message: "Please enter the event location.")
            return
        }
        
        guard let organizerPassword = passwordTextField.text, !organizerPassword.isEmpty else {
            showAlert(message: "Please enter the event date.")
            return
        }
        
        // Show loader while saving the event
        LoaderView.shared.show()
        
        let adminFeatures = AdminFeatures()
        let organizerModel = OrganizerModel(name: organizerName, email: organizerEmail, password: organizerPassword, contact: organizerPhoneNumber, imageURL: "", savedEvents: [])
        adminFeatures.createOrganizer(organizer: organizerModel) { [weak self] error in
            LoaderView.shared.hide()
            guard let self = self else { return }
            if let error = error {
                // Show an alert for the error
                self.showAlert(title: "Error", message: "Failed to add organizer: \(error.localizedDescription)")
            } else {
                // Show a success alert
                self.showAlert(title: "Success", message: "Organizer added successfully!")
                self.emptyAllFields()
            }
        }
    }
}
