//
//  User.swift
//  Levent
//
//  Created by Nawaf Al Lawati on 20/12/2024.
//

import Foundation

struct User: Codable {
    var id: String
    var name: String
    var email: String
    var password: String
    var isOrganizer: Bool
    var events: [String]?
    var gender: String?
    var interests: [String]?
}
