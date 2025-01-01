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
        
        // Get the selected date from the date picker
                selectedBirthday = datePicker.date
                // Get today's date without time component
                let today = Calendar.current.startOfDay(for: Date())
                // Get the selected date without time component
                let selectedDate = Calendar.current.startOfDay(for: selectedBirthday!)
                
                // Check if the selected date is today's date
        guard selectedDate != today else {
            // Show an alert if the selected date is today's date
            let alert = UIAlertController(title: "Error", message: "Please select your birthday.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
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
