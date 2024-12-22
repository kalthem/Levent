//
//  BoughtTicketsDetailsVC.swift
//  Levent
//
//   Created by Yusuf M on 9/12/2024.
//

import UIKit
class BoughtTicketsDetailsVC:
    UIViewController {
    
    var ticketDetails: TicketModel?
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventOrganizer: UILabel!
    @IBOutlet weak var totalTickets: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.dropShadow()
        eventImage.setImage(with: ticketDetails?.eventImageUrl)
        eventTitle.text = ticketDetails?.eventName
        eventLocation.text = ticketDetails?.eventLocation
        eventOrganizer.text = ticketDetails?.eventOrganizer
        totalTickets.text = "\(ticketDetails?.totalTickets ?? 0)"
        eventDate.text = ticketDetails?.eventDate
        eventTime.text = ticketDetails?.eventTime
        
    }
    
    @IBAction func addReviewButtonPressed(_ sender: Any) {
        guard let ticketDetails = ticketDetails else {
            showAlert(message: "Ticket details not available.")
            return
        }
        
        guard !ticketDetails.reviewAdded else {
            showAlert(message: "Review already added by you.")
            return
        }
        
        let addReviewVC: AddReviewVC = AddReviewVC.instantiate(appStoryboard: .tickets)
        addReviewVC.ticketData = ticketDetails
        navigationController?.pushViewController(addReviewVC, animated: true)
    }
    
}
