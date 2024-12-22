//
//  OrganizerModel.swift
//  Levent
//
// Created by Fatema Albaqali on 22/12/2024.
//

import Foundation
// MARK: - OrganizerModel
struct OrganizerModel: Codable {
    var name: String
    var email: String
    var password: String
    var contact: String
    var imageURL: String
    var savedEvents: [String] // IDs of saved event posts
}
