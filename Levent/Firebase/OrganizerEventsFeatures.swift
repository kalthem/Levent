//
//  StoreManagementFeatures.swift
//  Levent
//
//   Created by Fatema Albaqali on 21/12/2024.
//

import FirebaseFirestore

class OrganizerEventsFeatures {
    private let db = Firestore.firestore()

    func createEvent(event: EventModel, completion: @escaping (Error?) -> Void) {
        // Create a reference to a new document (this generates the document ID)
        let eventRef = db.collection("events").document()
        var updatedEvent = event
        updatedEvent.documentID = eventRef.documentID // Assign the generated document ID to the model

        // Save the event data to Firestore
        do {
            try eventRef.setData(from: updatedEvent, completion: completion)
        } catch {
            completion(error)
        }
    }

    // Update an existing event
    func updateEvent(event: EventModel, completion: @escaping (Error?) -> Void) {
        db.collection("events").whereField("documentID", isEqualTo: event.documentID).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let document = querySnapshot?.documents.first else {
                completion(NSError(domain: "AdminFeatures", code: 404, userInfo: [NSLocalizedDescriptionKey: "Event not found."]))
                return
            }
            
            do {
                try document.reference.setData(from: event, merge: true, completion: completion)
            } catch {
                completion(error)
            }
        }
    }


    // Remove an event
    func removeEvent(eventId: String, completion: @escaping (Error?) -> Void) {
        db.collection("events").document(eventId).delete(completion: completion)
    }

    // Fetch events created by an organizer
    func fetchOrganizerEvents(organizerEmail: String, completion: @escaping ([EventModel]?, Error?) -> Void) {
        db.collection("events").whereField("organizerEmail", isEqualTo: organizerEmail).getDocuments { (querySnapshot, error) in
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
    
    // Search events by name and organizer email
    func searchEvents(byName name: String, organizerEmail: String, completion: @escaping ([EventModel]?, Error?) -> Void) {
        let normalizedSearchText = name.lowercased()
        let endText = normalizedSearchText + "\u{f8ff}"

        db.collection("events")
            .whereField("eventName", isGreaterThanOrEqualTo: normalizedSearchText)
            .whereField("eventName", isLessThanOrEqualTo: endText)
            .whereField("organizerEmail", isEqualTo: organizerEmail)
            .getDocuments { (querySnapshot, error) in
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





    // Save an event for future reuse
    func saveEventForFuture(organizerId: String, eventId: String, completion: @escaping (Error?) -> Void) {
        let organizerRef = db.collection("organizers").document(organizerId)
        organizerRef.updateData(["savedEvents": FieldValue.arrayUnion([eventId])]) { error in
            completion(error)
        }
    }

    // Add highlights to an event
    func addEventHighlights(eventId: String, highlights: [String], completion: @escaping (Error?) -> Void) {
        db.collection("events").document(eventId).updateData(["highlights": FieldValue.arrayUnion(highlights)]) { error in
            completion(error)
        }
    }

    // Monitor event performance (likes, comments, ratings)
    func monitorEventPerformance(eventId: String, completion: @escaping ([FeedbackModel]?, Error?) -> Void) {
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





