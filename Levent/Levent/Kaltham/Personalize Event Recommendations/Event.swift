//
//  Event.swift
//  Levent
//
//  Created by k 3 on 24/12/2024.
//

import Foundation

struct Event: Codable {
    var name: String
    var category: Interest
    var date: Date
    var description: String
}


class EventSampleData {
    static let shared = EventSampleData()
    
    func generateSampleEvents() -> [Event] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        return [
            Event(name: "Community Meetup", category: .communityAndSocial, date: formatter.date(from: "2024/12/25 10:00")!, description: "A local community meetup."),
            Event(name: "Social Gathering", category: .communityAndSocial, date: formatter.date(from: "2024/12/26 14:00")!, description: "A social gathering for community members."),
            Event(name: "Fitness Bootcamp", category: .sportsAndFitness, date: formatter.date(from: "2024/12/27 08:00")!, description: "A bootcamp for fitness enthusiasts."),
            Event(name: "Yoga Session", category: .sportsAndFitness, date: formatter.date(from: "2024/12/28 09:00")!, description: "A relaxing yoga session."),
            Event(name: "Tech Conference", category: .techAndInnovation, date: formatter.date(from: "2024/12/29 11:00")!, description: "A conference on the latest in tech."),
            Event(name: "Innovation Workshop", category: .techAndInnovation, date: formatter.date(from: "2024/12/30 13:00")!, description: "A workshop on innovation."),
            Event(name: "Music Concert", category: .music, date: formatter.date(from: "2024/12/31 18:00")!, description: "A concert featuring local bands."),
            Event(name: "Jazz Night", category: .music, date: formatter.date(from: "2025/01/01 20:00")!, description: "An evening of jazz music."),
            Event(name: "Art Exhibition", category: .artAndCulture, date: formatter.date(from: "2025/01/02 10:00")!, description: "An exhibition of local art."),
            Event(name: "Cultural Festival", category: .artAndCulture, date: formatter.date(from: "2025/01/03 12:00")!, description: "A festival celebrating local culture.")
        ]
    }
}
