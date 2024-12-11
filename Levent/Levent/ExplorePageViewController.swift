//
//  ExplorePageViewController.swift
//  Levent
//
//  Created by Fatema Albaqali on 11/12/2024.
//

import UIKit

class ExplorePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHalfSheetSegue" {
            // Access the destination view controller
            if let destinationVC = segue.destination.presentationController as? UISheetPresentationController {
                // Customize the sheet's detents (e.g., half the screen)
                destinationVC.detents = [.medium()]
                
                // Optional: Make it draggable
                destinationVC.prefersGrabberVisible = true
            }
        }
    }




}
