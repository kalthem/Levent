//
//  CardDetailsVC.swift
//  Levent
//
//  Created by Fatema Albaqali on 20/12/2024.
//

import UIKit
class CardDetailsVC: UIViewController {
    
    var totalTicketsPrice: Double?
    var eventData: EventModel?
    var totalTickets: Int?
    
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expiryTextField: CustomTextField!
    @IBOutlet weak var cVVTextField: CustomTextField!
    @IBOutlet weak var nameTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        totalPrice.text = "\(String(describing: totalTicketsPrice ?? 0)) $"
        
    }
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        // Validate the text fields
        guard let cardNumber = cardNumberTextField.text, !cardNumber.isEmpty,
              let expiryDate = expiryTextField.text, !expiryDate.isEmpty,
              let cVV = cVVTextField.text, !cVV.isEmpty,
              let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "Please fill in all fields.") // Show alert if any field is empty
            return
        }
        let processingPaymentVC: ProcessingPaymentVC = ProcessingPaymentVC.instantiate(appStoryboard: .user)
        processingPaymentVC.eventData = eventData
        processingPaymentVC.totalAmount = totalTicketsPrice
        processingPaymentVC.totalTickets = totalTickets
        navigationController?.pushViewController(processingPaymentVC, animated: true)
    }
}
