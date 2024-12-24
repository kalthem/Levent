//
//  SelectBirthdayViewController.swift
//  Levent
//
//  Created by k 3 on 23/12/2024.
//

import UIKit

class SelectBirthdayViewController: UITableViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    var selectedGender: Gender?
    var selectedBirthday: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        if JSONStorage.shared.loadUser()?.birthday != nil {
            datePicker.date = JSONStorage.shared.loadUser()!.birthday!
        }
      
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
    }

    @IBAction func continueButtonTapped(_ sender: UIButton) {
        selectedBirthday = datePicker.date
   //     selectedBirthday = datePicker.date
                
                // Load the current user
                if var user = JSONStorage.shared.loadUser() {
                    // Update the birthday
                    user.birthday = selectedBirthday
                    
                    // Save the updated user back to storage
                    JSONStorage.shared.saveUser(user)
                }
                
//        performSegue(withIdentifier: "unwindToProfile", sender: self)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        selectedBirthday = datePicker.date
   //     selectedBirthday = datePicker.date
                
                // Load the current user
                if var user = JSONStorage.shared.loadUser() {
                    // Update the birthday
                    user.birthday = selectedBirthday
                    
                    // Save the updated user back to storage
                    JSONStorage.shared.saveUser(user)
                }
                
//        performSegue(withIdentifier: "unwindToProfile", sender: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       done()
    }
    
    func done(){
        selectedBirthday = datePicker.date
   //     selectedBirthday = datePicker.date
                
                // Load the current user
                if var user = JSONStorage.shared.loadUser() {
                    // Update the birthday
                    user.birthday = selectedBirthday
                    
                    // Save the updated user back to storage
                    JSONStorage.shared.saveUser(user)
                }
                
    }
}
