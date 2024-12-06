//
//  PersonalizeViewController.swift
//  Levent
//
//  Created by k 3 on 06/12/2024.
//

import UIKit

class PersonalizeViewController: UIViewController {
    @IBOutlet weak var btn_SelectGender: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func pdbGenderSelection(_ sender: UIAction) {
        
        print(sender.title)
        self.btn_SelectGender.setTitle(sender.title, for: .normal)
    }
    
    
}
