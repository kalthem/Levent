//
//  User.swift
//  Levent
//
//  Created by k 3 on 19/12/2024.
//


import Foundation

enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
}

enum Interest: String, Codable, CaseIterable {
    case communityAndSocial = "Community & Social"
    case sportsAndFitness = "Sports & Fitness"
    case techAndInnovation = "Tech & Innovation"
    case music = "Music"
    case artAndCulture = "Art & Culture"
}

struct User: Codable {
    var name: String
    var phoneNumber: String
    var email: String
    var password: String
    var gender: Gender?
    var birthday: Date?
  var interests: [Interest]? 
}
