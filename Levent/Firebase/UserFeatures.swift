//
//  UserFeatures.swift
//  Levent
//
//  Created by Fatema Albaqali on 21/12/2024.
//

import FirebaseFirestore
import FirebaseAuth

class UserFeatures {
    private let db = Firestore.firestore()



    // Add a new User
    func createUser(user: UserModel, completion: @escaping (Error?) -> Void) {
        // Check if the email already exists in either collection
        let userGroup = DispatchGroup()
        var emailExistsError: NSError?

        userGroup.enter()
        db.collection("users").whereField("email", isEqualTo: user.email).getDocuments { (querySnapshot, error) in
            if let error = error {
                emailExistsError = NSError(domain: "Users", code: 1, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
            } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                emailExistsError = NSError(domain: "Users", code: 1, userInfo: [NSLocalizedDescriptionKey: "User with the email \(user.email) already exists."])
            }
            userGroup.leave()
        }

        userGroup.enter()
        db.collection("organizers").whereField("email", isEqualTo: user.email).getDocuments { (querySnapshot, error) in
            if let error = error {
                emailExistsError = NSError(domain: "Organizers", code: 1, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
            } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                emailExistsError = NSError(domain: "Organizers", code: 1, userInfo: [NSLocalizedDescriptionKey: "Organizer with the email \(user.email) already exists."])
            }
            userGroup.leave()
        }

        userGroup.notify(queue: .main) {
            if let error = emailExistsError {
                completion(error)
                return
            }

            // Proceed to create the user if email is unique
            let userRef = self.db.collection("users").document()
            do {
                try userRef.setData(from: user, merge: true) { error in
                    completion(error)
                }
            } catch {
                completion(error)
            }
        }
    }
    
    func setupAccount(forEmail email: String, gender: String, birthday: String, interests: [String], completion: @escaping (Error?) -> Void) {
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let document = querySnapshot?.documents.first else {
                completion(NSError(domain: "UserFeatures", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user found with the email \(email)."]))
                return
            }
            
            let userRef = document.reference
            
            userRef.updateData([
                "gender": gender,
                "birthday": birthday,
                "interests": interests,
                "isVerified": true
            ]) { error in
                completion(error)
            }
        }
    }
    
    
    // Fetch all events
    func fetchAllEvents(completion: @escaping ([EventModel]?, Error?) -> Void) {
        db.collection("events").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            let events = querySnapshot?.documents.compactMap { doc -> EventModel? in
                var event = try? doc.data(as: EventModel.self)
                event?.documentID = doc.documentID // Assign the document ID
                return event
            }
            completion(events, nil)
        }
    }
    
    // Fetch events matching the provided interests
    func fetchInterestEvents(forInterests interests: [String], completion: @escaping ([EventModel]?, Error?) -> Void) {
        guard !interests.isEmpty else {
            print("No interests provided. Returning an empty array.")
            completion([], nil)
            return
        }
        
        print("Fetching events for interests: \(interests)")
        
        db.collection("events").whereField("eventCategory", in: interests).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching events for interests: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            print("Events fetched successfully for interests.")
            
            let events = querySnapshot?.documents.compactMap { doc -> EventModel? in
                var event = try? doc.data(as: EventModel.self)
                event?.documentID = doc.documentID // Assign the document ID
                return event
            }
            
            print("Number of events matching interests: \(events?.count ?? 0)")
            completion(events, nil)
        }
    }
    
    
    func fetchUserData(forEmail email: String, completion: @escaping (UserModel?, Error?) -> Void) {
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let document = querySnapshot?.documents.first else {
                print("No user found with the email \(email).")
                completion(nil, NSError(domain: "UserFeatures", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user found with the email \(email)."]))
                return
            }
            
            do {
                let userData = try document.data(as: UserModel.self)
                print("User data fetched successfully: \(userData)")
                completion(userData, nil)
            } catch {
                print("Error decoding user data: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
    }
    
    func updateUserData(forUser user: UserModel, completion: @escaping (Error?) -> Void) {
        let email = user.email // Directly access the non-optional email
        
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                completion(error)
                return
            }

            guard let document = querySnapshot?.documents.first else {
                print("No user found with the email \(email).")
                completion(NSError(domain: "UserFeatures", code: 404, userInfo: [NSLocalizedDescriptionKey: "No user found with the email \(email)."]))
                return
            }

            do {
                try self.db.collection("users").document(document.documentID).setData(from: user) { error in
                    if let error = error {
                        print("Error updating user data: \(error.localizedDescription)")
                        completion(error)
                    } else {
                        print("User data updated successfully for email \(email).")
                        completion(nil)
                    }
                }
            } catch {
                print("Error serializing user data: \(error.localizedDescription)")
                completion(error)
            }
        }
    }

    
    
    func buyTicket(ticket: TicketModel, completion: @escaping (Error?) -> Void) {
        let ticketRef = db.collection("tickets").document() // Firestore will generate a new document ID
        do {
            try ticketRef.setData(from: ticket) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }
    
    func fetchUserTickets(forEmail email: String, completion: @escaping ([TicketModel]?, Error?) -> Void) {
        db.collection("tickets").whereField("buyerEmail", isEqualTo: email).getDocuments { querySnapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            let tickets = querySnapshot?.documents.compactMap { doc -> TicketModel? in
                try? doc.data(as: TicketModel.self)
            }
            
            completion(tickets, nil)
        }
    }
    
    // Add a review to an event
    func addReview(toEvent eventId: String, review: EventModel.RatingReview, completion: @escaping (Error?) -> Void) {
        let eventRef = db.collection("events").document(eventId)
        
        // Update the ratingsAndReviews array in the event document
        eventRef.updateData([
            "ratingsAndReviews": FieldValue.arrayUnion([[
                "reviewerName": review.reviewerName,
                "rating": review.rating,
                "review": review.review
            ]])
        ]) { error in
            completion(error)
        }
    }

}


