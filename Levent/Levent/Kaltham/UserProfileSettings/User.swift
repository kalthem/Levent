//
//  User.swift
//  Levent
//
//  Created by k 3 on 19/12/2024.
//



import Foundation

struct User: Codable {
   // let username: String
    var name: String
    //var password: String
    var email: String
    var phoneNumber: String
    //let gender: String?
  //  let birthday: Date?
    //let interests: [String]?
    init(name: String, email: String, phoneNumber: String) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
}

func saveUser(user: User) {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601 // Set date encoding strategy

    do {
        let encoded = try encoder.encode(user) // Serialize User to JSON
        UserDefaults.standard.set(encoded, forKey: "savedUser") // Save to UserDefaults
    } catch {
        print("Failed to encode user: \(error)")
    }
}

func loadUser() -> User? {
    guard let data = UserDefaults.standard.data(forKey: "savedUser") else { return nil }
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601 // Set date decoding strategy

    do {
        let user = try decoder.decode(User.self, from: data) // Deserialize JSON to User
        return user
    } catch {
        print("Failed to decode user: \(error)")
        return nil
    }
}

func updateUserName(newName: String) {
    guard var user = loadUser() else {
        print("No user found to update.")
        return
    }
    
    user.name = newName // Update the name
    
    saveUser(user: user) // Save the updated user
    print("User name updated to \(newName).")
}

// Example usage function
func exampleUsage() {
//    let user = User(username: "john_doe", name: "John Doe", password: "securePassword123", email: "john@example.com", phoneNumber: "123-456-7890", gender: "Male", birthday: Date(), interests: ["Music", "Art & Culture"])
    let user = User(name: "John Doe", email: "john@example.com", phoneNumber: "123-456-7890")

    // Saving the user
    saveUser(user: user)

    // Loading the user
    if let loadedUser = loadUser() {
        print("User loaded: \(loadedUser.name)")
    } else {
        print("No user found.")
    }
}

