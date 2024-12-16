//
//  EditEventSuccessViewController.swift
//  Levent
//
//  Created by Yusuf M on 13/12/2024.
//

import UIKit

class EditEventSuccessViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.layer.cornerRadius = 10
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    


}
