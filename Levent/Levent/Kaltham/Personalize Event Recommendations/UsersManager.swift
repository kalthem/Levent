//
//  UsersManager.swift
//  Levent
//
//  Created by k 3 on 12/12/2024.
//

import Foundation
import CryptoKit

class UserManager {
    private var users: [User] = []
    private var currentUser: User?

    // MARK: - Sign Up
    func signUp(username: String, email: String, phoneNumber: String, password: String, userType: UserType) -> Bool {
        guard users.first(where: { $0.username == username }) == nil else {
            return false // User already exists
        }
        
        let hashedPassword = hashPassword(password)
        let newUser = User(username: username, email: email, phoneNumber: phoneNumber, hashedPassword: hashedPassword, userType: userType)
        users.append(newUser)
        return true
    }

    // MARK: - Login
    func login(username: String, password: String) -> Bool {
        guard let user = users.first(where: { $0.username == username }) else {
            return false // User not found
        }
        
        guard user.hashedPassword == hashPassword(password) else {
            return false // Invalid password
        }
        
        currentUser = user // Set current user upon successful login
        return true
    }

    // MARK: - Get Current User Type
    func getCurrentUserType() -> UserType? {
        return currentUser?.userType
    }

    // MARK: - Password Hashing
    private func hashPassword(_ password: String) -> String {
        let data = password.data(using: .utf8)!
        let hashed = SHA256.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
}
