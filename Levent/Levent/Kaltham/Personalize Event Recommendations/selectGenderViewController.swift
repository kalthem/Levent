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
//        maleButton.isSelected = false
//        femaleButton.isSelected = false
//        maleButton.backgroundColor = UIColor.clear // Default color
//        femaleButton.backgroundColor = UIColor.clear // Default color
//        
//        
//        if sender == maleButton {
//            maleButton.isSelected = true
//            maleButton.backgroundColor = maleButton.tintColor // Change to the desired selected color
//            user?.gender = Gender.male
//        } else if sender == femaleButton {
//            femaleButton.isSelected = true
//            femaleButton.backgroundColor = femaleButton.tintColor // Change to the desired selected color
//            user?.gender = Gender.female
//        }
//        
//        // Save the updated user data
//        if let user = user {
//            saveUser(user: user)
//        }
        if sender == maleButton {
                    selectedGender = .male
                } else if sender == femaleButton {
                    selectedGender = .female
                }
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
//        // Save the updated user data when continue is tapped
//        if let user = user {
//            saveUser(user: user)
//            print("User data saved. Gender: \(user.gender?.rawValue ?? "Not specified")")
//            // Navigate to the next screen, if needed
//        } else {
//            print("No user data to save.")
        
        guard let gender = selectedGender else {
                    // Show an alert if no gender is selected
                    let alert = UIAlertController(title: "Error", message: "Please select a gender.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
        }
        
        
        
//        func saveUser(user: User) {
//            let encoder = JSONEncoder()
//            do {
//                let encoded = try encoder.encode(user)
//                UserDefaults.standard.set(encoded, forKey: "savedUser")
//            } catch {
//                print("Failed to encode user: \(error)")
//            }
//        }
//    }
        
        // Load existing user data, update gender, and save
                var user = JSONStorage.shared.loadUser() ?? User(name: "", phoneNumber: "", email: "", password: "", gender: nil)
                user.gender = gender
                JSONStorage.shared.saveUser(user)
                
        // Perform the unwind segue
//        if let selectedGender = selectedGender,
//           let buttonTitle = continueButton.titleLabel?.text,
//           buttonTitle == "Done" {
//            performSegue(withIdentifier: "unwindToEditProfile", sender: self)
//        }
//                // Navigate to the user profile view
              //  performSegue(withIdentifier: "showUserProfile", sender: self)
            }
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
//        // Save the updated user data when continue is tapped
//        if let user = user {
//            saveUser(user: user)
//            print("User data saved. Gender: \(user.gender?.rawValue ?? "Not specified")")
//            // Navigate to the next screen, if needed
//        } else {
//            print("No user data to save.")
        
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
               
               // Perform the unwind segue
               //performSegue(withIdentifier: "unwindToEditProfile", sender: self)
           
        
//        func saveUser(user: User) {
//            let encoder = JSONEncoder()
//            do {
//                let encoded = try encoder.encode(user)
//                UserDefaults.standard.set(encoded, forKey: "savedUser")
//            } catch {
//                print("Failed to encode user: \(error)")
//            }
//        }
//    }
        
        
                
        // Perform the unwind segue
//        if let selectedGender = selectedGender,
//           let buttonTitle = continueButton.titleLabel?.text,
//           buttonTitle == "Done" {
//            performSegue(withIdentifier: "unwindToEditProfile", sender: self)
//        }
//                // Navigate to the user profile view
              //  performSegue(withIdentifier: "showUserProfile", sender: self)
        // Dismiss the current view controller
        
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
