//
//  RegistrationModel.swift
//  Levent
//
//  Created by Fatema Albaqali on 22/12/2024.
//

import Foundation
// MARK: - RegistrationModel
struct RegistrationModel: Codable {
    var registrationId: String
    var eventId: String
    var userId: String
    var status: String // e.g., "registered", "canceled"
    var timestamp: Date
}
