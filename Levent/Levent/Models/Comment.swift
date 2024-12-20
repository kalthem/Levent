//
//  Comment.swift
//  Levent
//
//  Created by Nawaf Al Lawati on 20/12/2024.
//

import Foundation
struct Comment: Codable {
    var id: String
    var eventId: String
    var userId: String
    var content: String
    var date: String
}
