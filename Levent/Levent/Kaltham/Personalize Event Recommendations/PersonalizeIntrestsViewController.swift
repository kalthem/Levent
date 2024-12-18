//
//  PersonalizeIntrestsViewController.swift
//  Levent
//
//  Created by k 3 on 14/12/2024.
//

import UIKit

class PersonalizeIntrestsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //    resetCheckbox()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var btnIsTapped: [UIButton]!
    var selectedInterests: [String] = []
    
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
        
        
        if let index = btnIsTapped.firstIndex(of: sender) {
            let button = btnIsTapped[index]
            button.isSelected.toggle()
            if button.isSelected {
                button.backgroundColor = button.tintColor
            }
            else if button.isSelected == false{
                button.backgroundColor = button.backgroundColor
            }
            else {
                button.backgroundColor = button.backgroundColor
            }
            
            
        }
        
    }
    @IBOutlet weak var btnSubmitIntrests: UIButton!
    
    @IBAction func btnSubmitIntrests(_ sender: UIButton) {
        UserDefaults.standard.set(selectedInterests, forKey: "selectedInterests")
    }
}
