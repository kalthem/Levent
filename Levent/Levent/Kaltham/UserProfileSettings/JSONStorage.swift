//
//  JSONStorage.swift
//  Levent
//
//  Created by k 3 on 22/12/2024.
//
import Foundation

class JSONStorage {
    static let shared = JSONStorage()
    private let filename = "user.json"

    private var fileURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(filename)
    }

    func saveUser(_ user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            try data.write(to: fileURL)
        } catch {
            print("Error saving user: \(error)")
        }
    }

    func loadUser() -> User? {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode(User.self, from: data)
        } catch {
            print("Error loading user: \(error)")
            return nil
        }
    }

    func createMockData() {
        let mockUser = User(
            name: "John Doe",
            phoneNumber: "123-456-7890",
            email: "john.doe@example.com",
            password: "password123",
            gender: nil,
            birthday: nil,
          interests: nil
        )
        saveUser(mockUser)
    }
}
