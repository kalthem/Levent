//
//  AdminFeatures.swift
//  Levent
//
//  Created by Fatema Albaqali on 21/12/2024.
//

import FirebaseFirestore

class AdminFeatures {
    private let db = Firestore.firestore()
    
    
    func getOrganizersList(completion: @escaping ([OrganizerModel], Error?) -> Void) {
        db.collection("organizers").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion([], error)
                return
            }

            let organizers = querySnapshot?.documents.compactMap { doc -> OrganizerModel? in
                try? doc.data(as: OrganizerModel.self)
            } ?? []

            completion(organizers, nil)
        }
    }
    
    func getOrganizer(byEmail email: String, completion: @escaping (OrganizerModel?, Error?) -> Void) {
        db.collection("organizers")
            .whereField("email", isEqualTo: email)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }

                guard let document = querySnapshot?.documents.first else {
                    completion(nil, NSError(domain: "AdminFeatures", code: 404, userInfo: [NSLocalizedDescriptionKey: "No organizer found with the given email."]))
                    return
                }

                do {
                    let organizer = try document.data(as: OrganizerModel.self)
                    completion(organizer, nil)
                } catch {
                    completion(nil, error)
                }
            }
    }
    
    func editOrganizer(organizerEmail: String, updatedOrganizer: OrganizerModel, completion: @escaping (Error?) -> Void) {
        db.collection("organizers").whereField("email", isEqualTo: organizerEmail).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(error)
                return
            }

            guard let document = querySnapshot?.documents.first else {
                completion(NSError(domain: "AdminFeatures", code: 404, userInfo: [NSLocalizedDescriptionKey: "Organizer not found."]))
                return
            }

            do {
                try document.reference.setData(from: updatedOrganizer, merge: true) { error in
                    completion(error)
                }
            } catch {
                completion(error)
            }
        }
    }


    
    
    func searchOrganizers(byName name: String, completion: @escaping ([OrganizerModel], Error?) -> Void) {
        let startText = name.lowercased() // Normalize to lowercase for consistency
        let endText = name.lowercased() + "\u{f8ff}" // Range end with Unicode '\u{f8ff}' for prefix matching

        db.collection("organizers")
            .whereField("name", isGreaterThanOrEqualTo: startText)
            .whereField("name", isLessThanOrEqualTo: endText)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion([], error)
                    return
                }

                let organizers = querySnapshot?.documents.compactMap { doc -> OrganizerModel? in
                    try? doc.data(as: OrganizerModel.self)
                } ?? []

                completion(organizers, nil)
            }
    }

    
    
    func createOrganizer(organizer: OrganizerModel, completion: @escaping (Error?) -> Void) {
        // Check if the email already exists in either collection
        let userGroup = DispatchGroup()
        var emailExistsError: NSError?

        userGroup.enter()
        db.collection("organizers").whereField("email", isEqualTo: organizer.email).getDocuments { (querySnapshot, error) in
            if let error = error {
                emailExistsError = NSError(domain: "Organizers", code: 1, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
            } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                emailExistsError = NSError(domain: "Organizers", code: 1, userInfo: [NSLocalizedDescriptionKey: "Organizer with the email \(organizer.email) already exists."])
            }
            userGroup.leave()
        }

        userGroup.enter()
        db.collection("users").whereField("email", isEqualTo: organizer.email).getDocuments { (querySnapshot, error) in
            if let error = error {
                emailExistsError = NSError(domain: "Users", code: 1, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
            } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                emailExistsError = NSError(domain: "Users", code: 1, userInfo: [NSLocalizedDescriptionKey: "User with the email \(organizer.email) already exists."])
            }
            userGroup.leave()
        }

        userGroup.notify(queue: .main) {
            if let error = emailExistsError {
                completion(error)
                return
            }

            // Proceed to create the organizer if email is unique
            let organizerRef = self.db.collection("organizers").document()
            do {
                try organizerRef.setData(from: organizer, merge: true) { error in
                    completion(error)
                }
            } catch {
                completion(error)
            }
        }
    }

    
    
    func deleteOrganizer(organizerEmail: String, completion: @escaping (Error?) -> Void) {
        // Reference to the organizer's collection
        let organizerRef = db.collection("organizers").whereField("email", isEqualTo: organizerEmail)

        // Fetch all events created by the organizer
        db.collection("events").whereField("organizerEmail", isEqualTo: organizerEmail).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(error)
                return
            }

            // Delete all events related to the organizer
            let batch = self.db.batch()
            querySnapshot?.documents.forEach { document in
                batch.deleteDocument(document.reference)
            }

            batch.commit { error in
                if let error = error {
                    completion(error)
                    return
                }

                // Now delete the organizer
                organizerRef.getDocuments { (querySnapshot, error) in
                    if let error = error {
                        completion(error)
                        return
                    }

                    guard let document = querySnapshot?.documents.first else {
                        completion(NSError(domain: "AdminFeatures", code: 404, userInfo: [NSLocalizedDescriptionKey: "Organizer not found."]))
                        return
                    }

                    document.reference.delete { error in
                        completion(error)
                    }
                }
            }
        }
    }


    
    func createAdmin(admin: AdminModel, completion: @escaping (Error?) -> Void) {
        let adminRef = db.collection("admins").document(admin.adminId)
        do {
            try adminRef.setData(from: admin, merge: true, completion: completion)
        } catch {
            completion(error)
        }
    }

    // Fetch all events created by organizers
    func fetchEventListings(completion: @escaping ([EventModel]?, Error?) -> Void) {
        db.collection("events").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            let events = querySnapshot?.documents.compactMap { doc -> EventModel? in
                try? doc.data(as: EventModel.self)
            }
            completion(events, nil)
        }
    }

    // Update event status (e.g., ongoing, completed, canceled)
    func updateEventStatus(eventId: String, status: String, completion: @escaping (Error?) -> Void) {
        db.collection("events").document(eventId).updateData(["status": status]) { error in
            completion(error)
        }
    }

    // Fetch feedback for an event
    func fetchEventFeedback(eventId: String, completion: @escaping ([FeedbackModel]?, Error?) -> Void) {
        db.collection("events").document(eventId).collection("feedback").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            let feedback = querySnapshot?.documents.compactMap { doc -> FeedbackModel? in
                try? doc.data(as: FeedbackModel.self)
            }
            completion(feedback, nil)
        }
    }

}

