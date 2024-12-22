

import UIKit
class BuyEventTicketsVC: UIViewController {
    
    var eventData : EventModel?
    var serviceFeeAmount: Double = 10.0
    var ticketCount: Int = 1
    
    @IBOutlet weak var GMSStepperView: UIView!
    @IBOutlet weak var ticketsPrice: UILabel!
    @IBOutlet weak var serviceFee: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var ticketsQuantity: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateTotalAmount()
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        ticketCount += 1  // Increase ticket count by 1
        updateTotalAmount()  // Update the UI dynamically
    }
    
    @IBAction func subtractButtonPressed(_ sender: Any) {
        if ticketCount > 1 {  // Ensure the ticket count doesn't go below 1
            ticketCount -= 1  // Decrease ticket count by 1
            updateTotalAmount()  // Update the UI dynamically
        }
       
    }
    
    
    @IBAction func BuyButtonPressed(_ sender: Any) {
        let cardDetailsVC: CardDetailsVC = CardDetailsVC.instantiate(appStoryboard: .user)
        cardDetailsVC.eventData = eventData
        cardDetailsVC.totalTicketsPrice = Double(totalAmount.text ?? "0")
        cardDetailsVC.totalTickets = ticketCount
        navigationController?.pushViewController(cardDetailsVC, animated: true)
    }
    
    
    func updateTotalAmount() {
        guard let ticketPrice = eventData?.eventTicketPrice else {
            print("Error: Event ticket price not found")
            return
        }
        
        // Calculate the total price
        let totalPrice = ticketPrice * Double(ticketCount)
        let total = totalPrice + serviceFeeAmount
        
        // Update the UI
        ticketsQuantity.text = "\(ticketCount)"
        ticketsPrice.text = "\(totalPrice)"
        serviceFee.text = "\(serviceFeeAmount)"
        totalAmount.text = "\(total)"
    }
    
    private func calculateTotalAmount() -> Double {
        guard let ticketPrice = eventData?.eventTicketPrice else {
            print("Error: Event ticket price not found")
            return 0.0
        }
        let totalPrice = ticketPrice * Double(ticketCount)
        return totalPrice + serviceFeeAmount
    }
    
}
