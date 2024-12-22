//
//  EventModel.swift
//  Levent
//
//  Created by Fatema Albaqali on 22/12/2024.
//

import Foundation
// MARK: - EventModel
struct EventModel: Codable {
    var documentID: String
    var eventName: String
    var eventDescription: String
    var eventDate: String
    var eventTime: String
    var eventCategory: String
    var eventLocation: String
    var eventTicketPrice: Double
    var status: String
    var organizerEmail: String
    var organizerName: String
    var imageUrl: String
    var feedbackCount: Int
    var ticketsSold: Int
    var ratingsAndReviews: [RatingReview]?
    
    // MARK: - RatingReview
    struct RatingReview: Codable {
        var reviewerName: String
        var rating: Int // Rating given to the event
        var review: String // Review text
    }
}
