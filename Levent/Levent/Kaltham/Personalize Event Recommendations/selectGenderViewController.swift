//
//  selectGenderViewController.swift
//  Levent
//
//  Created by k 3 on 15/12/2024.
//

import UIKit

class selectGenderViewController: UIViewController {
    internal var selectedGender: Gender?
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
//    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        JSONStorage.shared.createMockData() // Ensure mock data exists
    
        
    }
    @IBAction func genderButtonTapped(_ sender: UIButton) {
        
        // Reset background colors for both buttons
        maleButton.backgroundColor = .white
          femaleButton.backgroundColor = .white
        
        // Set the selected gender and change background color of the selected button
        if sender == maleButton {
            selectedGender = .male
            maleButton.backgroundColor = .tintColor // Change to a different color to indicate selection
        } else if sender == femaleButton {
            selectedGender = .female
            femaleButton.backgroundColor = .tintColor // Change to a different color to indicate selection
        }    }
    
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        
        guard let gender = selectedGender else {
                    // Show an alert if no gender is selected
                    let alert = UIAlertController(title: "Error", message: "Please select a gender.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
        }
        
        
        // Load existing user data, update gender, and save
                var user = JSONStorage.shared.loadUser() ?? User(name: "", phoneNumber: "", email: "", password: "", gender: nil)
                user.gender = gender
                JSONStorage.shared.saveUser(user)
                
            }
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {

        
        guard let gender = selectedGender else {
                    // Show an alert if no gender is selected
                    let alert = UIAlertController(title: "Error", message: "Please select a gender.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
        }
        
        // Load existing user data, update gender, and save
               var user = JSONStorage.shared.loadUser() ?? User(name: "", phoneNumber: "", email: "", password: "", gender: nil)
               user.gender = gender
               JSONStorage.shared.saveUser(user)

        
            }
    override func viewWillDisappear(_ animated: Bool) {
       done()
    }
    
    func done(){
        guard let gender = selectedGender else {
                    // Show an alert if no gender is selected
                    let alert = UIAlertController(title: "Error", message: "Please select a gender.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
        }
        
        // Load existing user data, update gender, and save
               var user = JSONStorage.shared.loadUser() ?? User(name: "", phoneNumber: "", email: "", password: "", gender: nil)
               user.gender = gender
               JSONStorage.shared.saveUser(user)
        
    }
  
}
