//
//  EventEditSuccessVC.swift
//  Levent
//
//   Created by Yusuf M on 9/12/2024.
//

import UIKit

class EventEditSuccessVC: UIViewController {
    
    var isOrganizer:Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if isOrganizer == true {
            let storyboard = UIStoryboard(name: "Organizer", bundle: nil)
            if let adminViewController = storyboard.instantiateViewController(withIdentifier: "OrganizerTabBarVC") as? UITabBarController {
                self.navigationController?.setViewControllers([adminViewController], animated: true) }
            return
        } else {
            let storyboard = UIStoryboard(name: "Admin", bundle: nil)
            if let adminViewController = storyboard.instantiateViewController(withIdentifier: "AdminTabBarVC") as? UITabBarController {
                self.navigationController?.setViewControllers([adminViewController], animated: true) }
            return
        }
    }
}
