//
//  NotificationsXibTableView.swift
//  Levent
//
//  Created by Mahdi on 18/12/2024.
//

import UIKit

class NotificationsXibTableView: UITableViewCell{
    
    
    @IBOutlet weak var notificationText: UILabel!
    
    @IBOutlet weak var shadowView: UIView!
    override func awakeFromNib()  {
        super.awakeFromNib()
        shadowView.dropShadow()
    }
    
    func addCellDatawithTicketData(ticketModel: TicketModel) {
        let notificationData = "You purchased \(ticketModel.totalTickets) tickets for \(ticketModel.eventName)"
        notificationText.text = notificationData
        
    }
}
