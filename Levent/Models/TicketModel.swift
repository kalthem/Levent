//
//  CategoryModel.swift
//  Levent
//
//  Created by Fatema Albaqali on 22/12/2024.
//

import Foundation
// MARK: - CategoryModel
struct TicketModel: Codable {
    var eventId: String
    var buyerEmail: String
    var buyerName: String
    var totalTickets: Int
    var totalPrice: Double
    var eventImageUrl: String
    var eventDate: String
    var eventTime: String
    var eventOrganizer: String
    var eventName: String
    var eventLocation: String
    var reviewAdded: Bool
}
