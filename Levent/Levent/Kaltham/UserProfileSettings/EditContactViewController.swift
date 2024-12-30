//
//  EditContactViewController.swift
//  Levent
//
//  Created by k 3 on 27/12/2024.
//

import UIKit

class EditPhoneNumberViewController: UIViewController {
        
    @IBOutlet weak var newPhoneNumber: UITextField!
    @IBOutlet weak var doneButtonTapped: UIButton!
    var phoneNumber: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPhoneNumber.text = JSONStorage.shared.loadUser()!.phoneNumber
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        phoneNumber = newPhoneNumber.text ?? ""
        if var user = JSONStorage.shared.loadUser() {
            // Update the name
            user.phoneNumber = phoneNumber
            
            // Save the updated user back to storage
            JSONStorage.shared.saveUser(user)
            
        }
                
               
            }
       
    
    override func viewWillDisappear(_ animated: Bool) {
        done()
        
    }
    
    func done(){
        phoneNumber = newPhoneNumber.text ?? ""
        if var user = JSONStorage.shared.loadUser() {
            // Update the name
            user.phoneNumber = phoneNumber
            
            // Save the updated user back to storage
            JSONStorage.shared.saveUser(user)
        }
        
        
    }
    
}


class EditEmailViewController: UIViewController {
    
    @IBOutlet weak var newEmail: UITextField!
    @IBOutlet weak var doneButtonTapped: UIButton!
    var email: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newEmail.text = JSONStorage.shared.loadUser()!.email
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let newEmailText = newEmail.text, isValidEmail(newEmailText) else {
                    showAlert(title: "Error", message: "Please enter a valid email address.")
                    return
                }
        email = newEmail.text ?? ""
        if var user = JSONStorage.shared.loadUser() {
            // Update the name
            user.email = email
            
            // Save the updated user back to storage
            JSONStorage.shared.saveUser(user)
            
        }
                
            }
            
            private func isValidEmail(_ email: String) -> Bool {
                // Basic email validation
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailPred.evaluate(with: email)
            }
            
            private func showAlert(title: String, message: String) {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    if title == "Success" {
                        self.navigationController?.popViewController(animated: true)
                    }
                }))
                present(alert, animated: true, completion: nil)
            }
    
   
   
    override func viewWillDisappear(_ animated: Bool) {
        done()

    }
    
    func done(){
        email = newEmail.text ?? ""
        if var user = JSONStorage.shared.loadUser() {
            // Update the name
            user.email = email
            
            // Save the updated user back to storage
            JSONStorage.shared.saveUser(user)
            
        }
        
        
    }
        }
