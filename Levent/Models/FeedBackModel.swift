//
//  FeedBackModel.swift
//  Levent
//
//  Created by Fatema Albaqali on 22/12/2024.
//

import Foundation
// MARK: - FeedbackModel
struct FeedbackModel: Codable {
    var feedbackId: String
    var userId: String
    var eventId: String
    var rating: Double
    var comment: String
    var type: String // e.g., "like", "report"
    var reportReason: String? // e.g., "misleading", "inappropriate"
    var timestamp: Date
}
