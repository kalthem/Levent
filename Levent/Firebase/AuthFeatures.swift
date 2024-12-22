//
//  AuthFeatures.swift
//  Levent
//
//  Created by Fatema Albaqali on 21/12/2024.
//

import FirebaseFirestore
import Foundation

class AuthFeatures {
    private let db = Firestore.firestore()

    /// Sign in by checking both `users` and `organizers` collections
    func signIn(email: String, password: String, completion: @escaping (String?, Bool?, String?, [String]?, Error?) -> Void) {
        let userGroup = DispatchGroup()
        var role: String?
        var isVerified: Bool?
        var name: String?
        var interests: [String] = [] // Initialize an empty array for interests
        var checkError: Error?

        // Check the `users` collection
        userGroup.enter()
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
            if let error = error {
                checkError = error
            } else if let document = querySnapshot?.documents.first, let userData = document.data() as? [String: Any] {
                if let storedPassword = userData["password"] as? String, storedPassword == password {
                    role = "user"
                    isVerified = userData["isVerified"] as? Bool ?? false // Fetch isVerified status for users
                    name = userData["name"] as? String
                    if let userInterests = userData["interests"] as? [String] {
                        interests = userInterests // Assign interests if they exist
                    }
                } else {
                    checkError = NSError(domain: "AuthFeatures", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid password for user."])
                }
            }
            userGroup.leave()
        }

        // Check the `organizers` collection
        userGroup.enter()
        db.collection("organizers").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
            if let error = error {
                checkError = error
            } else if let document = querySnapshot?.documents.first, let organizerData = document.data() as? [String: Any] {
                if let storedPassword = organizerData["password"] as? String, storedPassword == password {
                    role = "organizer"
                    name = organizerData["name"] as? String
                    isVerified = true // Always true for organizers
                    interests = [] // Always return an empty array for organizers
                } else {
                    checkError = NSError(domain: "AuthFeatures", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid password for organizer."])
                }
            }
            userGroup.leave()
        }

        // Notify when both checks are completed
        userGroup.notify(queue: .main) {
            if let error = checkError {
                completion(nil, nil, nil, nil, error)
            } else if let role = role, let isVerified = isVerified, let name = name {
                completion(role, isVerified, name, interests, nil) // Pass the interests along with other data
            } else {
                let roleError = NSError(
                    domain: "AuthFeatures",
                    code: 404,
                    userInfo: [NSLocalizedDescriptionKey: "No account found for the provided email."]
                )
                completion(nil, nil, nil, nil, roleError)
            }
        }
    }

}
