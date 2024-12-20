//
//  DataStorage.swift
//  Levent
//
//  Created by Nawaf Al Lawati on 20/12/2024.
//

import Foundation
import UIKit

class DataStorage {
    static let shared = DataStorage()
    private init() {}
    
    private let currentUserKey = "currentUser"

    func setCurrentUser(_ user: User) {
        let defaults = UserDefaults.standard
        if let encodedUser = try? JSONEncoder().encode(user) {
            defaults.set(encodedUser, forKey: currentUserKey)
        }
    }

    func getCurrentUser() -> User? {
        let defaults = UserDefaults.standard
        if let savedUserData = defaults.data(forKey: currentUserKey) {
            return try? JSONDecoder().decode(User.self, from: savedUserData)
        }
        return nil
    }

    func save<T: Codable>(_ data: [T], to fileName: String) -> Bool {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: url)
            return true
        } catch {
            print("Error saving data to \(fileName): \(error)")
            return false
        }
    }


    func load<T: Codable>(_ type: [T].Type, from fileName: String) -> [T] {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print("Error loading data from \(fileName): \(error)")
            return []
        }
    }
    
    func saveImage(_ image: UIImage, withName name: String) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let filePath = getDocumentsDirectory().appendingPathComponent(name)
        do {
            try data.write(to: filePath)
            return filePath.lastPathComponent
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
    
    func loadImage(named name: String) -> UIImage? {
        let filePath = getDocumentsDirectory().appendingPathComponent(name)
        return UIImage(contentsOfFile: filePath.path)
    }



    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
