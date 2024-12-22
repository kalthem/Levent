//
//  UserModel.swift
//  Levent
//
//  Created by Fatema Albaqali on 21/12/2024.
//

import Foundation
// MARK: - UserModel
struct UserModel: Codable {
    var name: String
    var email: String
    var password: String
    var isVerified: Bool
    var profileImage: String
    var gender: String
    var birthday: String
    var interests: [String]
    
}

