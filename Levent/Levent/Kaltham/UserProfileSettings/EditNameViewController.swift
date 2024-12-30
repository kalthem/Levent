//
//  EditName.swift
//  Levent
//
//  Created by k 3 on 26/12/2024.
//

import UIKit

class EditNameViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = JSONStorage.shared.loadUser()!.name
        
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        name = nameTextField.text ?? ""
        if var user = JSONStorage.shared.loadUser() {
            // Update the name
            user.name = name
            
            // Save the updated user back to storage
            JSONStorage.shared.saveUser(user)
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        done()
        
    }
    
    func done(){
        name = nameTextField.text ?? ""
        if var user = JSONStorage.shared.loadUser() {
            // Update the name
            user.name = name
            
            // Save the updated user back to storage
            JSONStorage.shared.saveUser(user)
        }
        
        
    }
}
