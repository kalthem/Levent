//
//  EventDetailViewController.swift
//  Levent
//
//  Created by Yusuf M on 9/12/2024.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    var didTriggerSegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.layer.cornerRadius = 10
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !didTriggerSegue {
            tabBarController?.tabBar.isHidden = false
        }
        didTriggerSegue = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainImageView.layer.cornerRadius = 10
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        didTriggerSegue = true
        performSegue(withIdentifier: "EditEventSegue", sender: nil)
    }
    

}
