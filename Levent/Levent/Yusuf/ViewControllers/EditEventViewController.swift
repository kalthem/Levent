//
//  EditEventViewController.swift
//  Levent
//
//  Created by Yusuf M on 9/12/2024.
//

import UIKit

class EditEventViewController: UIViewController {
    
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var eventLocationTextField: UITextField!
    @IBOutlet weak var eventDateTextField: UITextField!
    @IBOutlet weak var ticketPriceTextField: UITextField!
    @IBOutlet weak var eventImageView: UIImageView!
    
    @IBOutlet weak var editEventButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        editEventButton.layer.cornerRadius = 10
        eventImageView.layer.cornerRadius = 10
    }
    
    @IBAction func changePictureButtonTapped(_ sender: Any) {
        
        let pictureOptionsAlert = UIAlertController(title: "Change Picture", message: "Choose an option to upload a picture.", preferredStyle: .actionSheet)
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        
        pictureOptionsAlert.addAction(photoLibrary)
        pictureOptionsAlert.addAction(camera)
        pictureOptionsAlert.addAction(cancelAction)
        
        present(pictureOptionsAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func editEventButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "EditEventSuccesSegue", sender: nil)
        
    }

}
