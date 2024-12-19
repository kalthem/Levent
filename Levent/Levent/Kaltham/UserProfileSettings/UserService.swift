//
//  UserService.swift
//  Levent
//
//  Created by k 3 on 19/12/2024.
//

import Foundation

class UserService {
        private let fileName = "user.json"

        // Load user data from a file
        func loadUser() -> User? {
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                return try decoder.decode(User.self, from: data)
            } catch {
                print("Failed to load user data: \(error)")
                return nil
            }
        }

        // Save user data to a file
        func saveUser(user: User) {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(user)
                let url = getDocumentsDirectory().appendingPathComponent(fileName)
                try data.write(to: url)
                print("User data saved successfully at \(url.path)")
            } catch {
                print("Failed to save user data: \(error)")
            }
        }

        // Create a mock user
        func createMockUser() {
            let mockUser = User(name: "Jane Doe", email: "jane.doe@example.com", phoneNumber: "555-1234")
            saveUser(user: mockUser)  // Save the mock user to user.json
        }

        // Helper to get the documents directory
        private func getDocumentsDirectory() -> URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
    }

