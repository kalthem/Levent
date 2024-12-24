//
//  PersonalizeIntrestsViewController.swift
//  Levent
//
//  Created by k 3 on 14/12/2024.
//

import UIKit

class PersonalizeInterestsViewController: UIViewController {
    
    
    @IBOutlet var btnIsTapped: [UIButton]!
    @IBOutlet weak var btnSubmitInterests: UIButton!
    var selectedInterests: Set<Interest> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSelectedInterests()
        btnSubmitInterests.isEnabled = false
    }
    
    @IBAction func btnTapped  (_ sender: UIButton)  {
        //        for button in btnIsTapped {
        //                if button == sender {
        //                    if button.backgroundColor == .green {
        //                        button.backgroundColor = .white
        //                    } else {
        //                        button.backgroundColor = .green
        //                    }
        //                } else {
        //                    button.backgroundColor = .white
        //                }
        //            }
        
        
        //        if let index = btnIsTapped.firstIndex(of: sender) {
        //            let button = btnIsTapped[index]
        //            button.isSelected.toggle()
        //            if button.isSelected {
        //                button.backgroundColor = button.tintColor
        //            }
        //            else if button.isSelected == false{
        //                button.backgroundColor = button.backgroundColor
        //            }
        //            else {
        //                button.backgroundColor = button.backgroundColor
        //            }
        //
        //
        //        }
        
        guard let interestTitle = sender.titleLabel?.text,
              let interest = Interest(rawValue: interestTitle) else { return }
        
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.backgroundColor = sender.tintColor
            selectedInterests.insert(interest)
        } else {
            sender.backgroundColor = .white
            selectedInterests.remove(interest)
        }
        
        // Enable the submit button if at least 2 interests are selected
        btnSubmitInterests.isEnabled = selectedInterests.count >= 2
    }
    
    @IBAction func btnSubmitInterests(_ sender: UIButton) {
        if var user = JSONStorage.shared.loadUser() {
            user.interests = Array(selectedInterests)
            JSONStorage.shared.saveUser(user)
            
        }
    }
    
    private func loadSelectedInterests() {
            if let user = JSONStorage.shared.loadUser(), let interests = user.interests {
                selectedInterests = Set(interests)
                for button in btnIsTapped {
                    if let interestTitle = button.titleLabel?.text,
                       let interest = Interest(rawValue: interestTitle),
                       selectedInterests.contains(interest) {
                        button.isSelected = true
                        button.backgroundColor = button.tintColor
                    } else {
                        button.isSelected = false
                        button.backgroundColor = .white
                    }
                }
            }
        }
}
