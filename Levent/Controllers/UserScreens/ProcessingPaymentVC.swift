//
//  ProcessingPaymentVC.swift
//  Levent
//
//  Created by Fatema Albaqali on 20/12/2024.
//

import UIKit
class ProcessingPaymentVC: UIViewController {
    
    var eventData: EventModel?
    var totalAmount: Double?
    var totalTickets: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let userEmail = UserSessionManager.shared.getLoggedInUserEmail() else {
            print("No logged-in user email found.")
            return
        }

        let userFeatures = UserFeatures()
        userFeatures.fetchUserData(forEmail: userEmail) { [weak self] userData, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let userData = userData {
                self?.processTicketPurchase(user: userData)
            }
        }
    }
    
    private func processTicketPurchase(user: UserModel) {
        guard let event = eventData,
              let totalAmount = totalAmount,
              let totalTickets = totalTickets else {
            print("Missing event data, total amount, or total tickets.")
            return
        }

        // Create the TicketModel instance
        let ticket = TicketModel(
            eventId: event.documentID,
            buyerEmail: user.email,
            buyerName: user.name,
            totalTickets: totalTickets,
            totalPrice: totalAmount,
            eventImageUrl: event.imageUrl,
            eventDate: event.eventDate,
            eventTime: event.eventTime,
            eventOrganizer: event.organizerName,
            eventName: event.eventName,
            eventLocation: event.eventLocation,
            reviewAdded: false
        )

        // Call the UserFeatures to store the ticket in Firestore
        let userFeatures = UserFeatures()
        userFeatures.buyTicket(ticket: ticket) { error in
            if let error = error {
                print("Failed to purchase ticket: \(error.localizedDescription)")
            } else {
                let paymentSuccessVC: PaymentSuccessVC = PaymentSuccessVC.instantiate(appStoryboard: .user)
                self.navigationController?.pushViewController(paymentSuccessVC, animated: true)
            }
        }
    }

}
