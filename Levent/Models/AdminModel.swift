//
//  AdminModel.swift
//  Levent
//
//  Created by Fatema Albaqali on 22/12/2024.
//

import Foundation
// MARK: - AdminModel
struct AdminModel: Codable {
    var adminId: String
    var name: String
    var email: String
    var password: String
    var permissions: [String]
    var managedCategories: [String]?
}
