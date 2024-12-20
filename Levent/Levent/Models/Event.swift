//
//  Event.swift
//  Levent
//
//  Created by Nawaf Al Lawati on 20/12/2024.
//

import Foundation
struct Event: Codable {
    var id: String
    var name: String
    var artistName: String
    var location: String
    var date: String
    var ticketPrice: Double
    var ticketsSold: Int
    var totalTickets: Int
    var organizerId: String
    var comments: [String]
    var imagePath: String?
}

