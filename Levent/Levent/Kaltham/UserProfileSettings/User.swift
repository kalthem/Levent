//
//  User.swift
//  Levent
//
//  Created by k 3 on 19/12/2024.
//



//import Foundation
//
//struct User: Codable {
//    var name: String
//    var email: String
//    var phoneNumber: String
//    var password: String? // Added password
//    var gender: Gender? // Optional
//    var birthday: Date? // Optional
//    var interests: [String]? // Optional
//
//    init(name: String, email: String, phoneNumber: String, password: String) {
//        self.name = name
//        self.email = email
//        self.phoneNumber = phoneNumber
//        self.password = password
//        self.gender = nil
//        self.birthday = nil
//        self.interests = nil
//    }
//}
//
//enum Gender: String, Codable {
//    case male
//    case female
//}
//
//func saveUser(user: User) {
//    let encoder = JSONEncoder()
//    encoder.dateEncodingStrategy = .iso8601
//
//    do {
//        let encoded = try encoder.encode(user)
//        UserDefaults.standard.set(encoded, forKey: "savedUser")
//    } catch {
//        print("Failed to encode user: \(error)")
//    }
//}
//
//func loadUser() -> User? {
//    guard let data = UserDefaults.standard.data(forKey: "savedUser") else { return nil }
//    let decoder = JSONDecoder()
//    decoder.dateDecodingStrategy = .iso8601
//
//    do {
//        let user = try decoder.decode(User.self, from: data)
//        return user
//    } catch {
//        print("Failed to decode user: \(error)")
//        return nil
//    }
//}
//
//// Example usage function
//func exampleUsage() {
//    // Create a user with only required fields
//    let user = User(name: "John Doe", email: "john@example.com", phoneNumber: "123-456-7890", password: "securePassword123")
//
//    // Saving the user
//    saveUser(user: user)
//
//    // Loading the user
//    if let loadedUser = loadUser() {
//        print("User loaded: \(loadedUser.name), Email: \(loadedUser.email)")
//    } else {
//        print("No user found.")
//    }
//}
//
//// Function to update user details
//func updateUserDetails(gender: Gender?, birthday: Date?, interests: [String]?) {
//    guard var user = loadUser() else {
//        print("No user found to update.")
//        return
//    }
//
//    user.gender = gender
//    user.birthday = birthday
//    user.interests = interests
//
//    saveUser(user: user)
//    print("User details updated.")
//}

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
