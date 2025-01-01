//
//  Event.swift
//  Levent
//
//  Created by k 3 on 24/12/2024.
//

import Foundation
import UIKit

// Define a struct to represent an Event, conforming to Codable for easy encoding/decoding
struct Event: Codable {
    var imageName: String // Name of the image file for the event
    var interests: [Interest] // Array of interests associated with the event
}

// Sample data for events
let events: [Event] = [
    Event( imageName: "music_festival", interests: [.music]),
    Event( imageName: "art_exhibition", interests: [.artAndCulture]),
    Event(imageName: "tech_conference", interests: [.techAndInnovation]),
    Event(imageName: "sports1", interests: [.sportsAndFitness]),
    Event(imageName: "community1", interests: [.communityAndSocial]),
    Event( imageName: "music2", interests: [.music]),
    Event( imageName: "art", interests: [.artAndCulture]),
    Event(imageName: "tech", interests: [.techAndInnovation]),
    Event(imageName: "sports2", interests: [.sportsAndFitness]),
    Event(imageName: "community2", interests: [.communityAndSocial]),
]

// Function to filter events based on user interests
func filterEvents(basedOnInterests interests: [Interest]) -> [Event] {
    return events.filter { event in
        // Check if any of the event's interests match the user's interests
        return !Set(event.interests).intersection(interests).isEmpty
    }
}


// Class to manage event storage and retrieval
class EventStorage {
    static let shared = EventStorage() // Singleton instance
    private var filename = "events.json" // Name of the JSON file to save events

    // Property that constructs the file URL for saving and retrieving events data
    public var fileURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(filename)
    }
       

    // Function to save events to a JSON file
    func saveEventsToJSONFile(events: [Event], fileName: String) {
        do {
            let jsonData = try JSONEncoder().encode(events) // Encode events to JSON data
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent(fileName)// Create file URL
                try jsonData.write(to: fileURL)
                print("Events saved to: \(fileURL)") // print the file URL
            }
        } catch {
            print("Error saving JSON to file: \(error)") // print the error details for debugging purposes
        }
    }

    

    // Function to load events from the JSON file
    func loadEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        saveEventsToJSONFile(events: events, fileName: "events.json") // Save events initially
        print(fileURL)// print the file URL
        
        // Load events in a background thread
        DispatchQueue.global(qos: .background).async {
            do {
                if FileManager.default.fileExists(atPath: self.fileURL.path) {// Check if the file exists
                    let data = try Data(contentsOf: self.fileURL) //Read data from file
                    let events = try JSONDecoder().decode([Event].self, from: data)// Decode the data
                    DispatchQueue.main.async {
                        completion(.success(events)) // Return loaded events on the main thread
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.success([])) // Return an empty array if file doesn't exist
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))// Return error on failure
                }
            }
        }
    }
}


// UICollectionViewCell subclass to represent an event in a collection view
class EventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! // Image view for displaying event image

    override func awakeFromNib() {
        super.awakeFromNib()
        // Enable accessibility for the image view
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "Event image"
        imageView.accessibilityHint = "Displays the event's image"
    }

    // Function to configure the cell with an event
    func configure(with event: Event) {
        imageView.image = UIImage(named: event.imageName)
        print("Configuring cell with image: \(event.imageName)")
    }
}


// UITableViewCell subclass to display a collection of events
class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView! // Collection view to show events
    
    private var events: [Event] = [] // Array to hold events for this cell

    override func awakeFromNib() {
            super.awakeFromNib()
            collectionView.dataSource = self // Set data source
            collectionView.delegate = self // Set delegate
            collectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventCollectionViewCell") // Register cell
            // Enable accessibility for the collection view
            collectionView.isAccessibilityElement = true
            collectionView.accessibilityLabel = "Event images collection"
            collectionView.accessibilityHint = "Displays a collection of event images"
        }

    // Function to configure the cell with an array of events
    func configure(with events: [Event]) {
        self.events = events // Assign events to the cell
        print("Configuring with events: \(events)") // Debugging line
        collectionView.reloadData() // Reload collection view data
    }
}

// Extension to conform to UICollectionViewDataSource and UICollectionViewDelegateFlowLayout protocols
extension EventTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count // Return the number of events
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
        let event = events[indexPath.item] // Get the event for this index
        cell.configure(with: event) // Configure the cell
        return cell // Return the configured cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250) // Set size for the collection view cells
    }
}


// View controller to display all events
class AllEventsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! // Table view to display event cells
    
    private var events: [Event] = [] // Array to hold events
    private var userInterests: Set<Interest> = [] // Set of user interests
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recommendations" // Set the title of the view
        tableView.dataSource = self // Set data source
        tableView.delegate = self // Set delegate
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell") // Register the table view cell
        loadUserInterests() // Load user interests
        loadEvents() // Load events
            }
            
    
          // Function to load user interests from storage
            private func loadUserInterests() {
                if let user = JSONStorage.shared.loadUser(), let interests = user.interests {
                    userInterests = Set(interests) // Convert interests to a Set for easier comparison
                }
            }
    
    // Function to load events based on user interests
        private func loadEvents() {
        EventStorage.shared.loadEvents { [weak self] result in
            switch result {
            case .success(let loadedEvents):
                print("Loaded events: \(loadedEvents)") // // Log loaded events for debugging
                self?.events = loadedEvents.filter { event in // Filter events based on user interests
                    !Set(event.interests).isDisjoint(with: self?.userInterests ?? [])
                }
                print("Filtered events: \(String(describing: self?.events))") // Debugging line
                self?.tableView.reloadData() // Log filtered events
            case .failure(let error):
                print("Failed to load events: \(error)") // Log any errors
            }
        }
    }
    
    
    
}

// Extension to conform to UITableViewDataSource and UITableViewDelegate protocols
    extension AllEventsViewController: UITableViewDataSource, UITableViewDelegate {
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1 // Single section for the table view
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("Number of rows: \(events.count > 0 ? 1 : 0)") // Log the number of rows for debugging
            return events.count > 0 ? 1 : 0 //Return 1 if there are events, otherwise return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
            cell.configure(with: events) // Configure the cell with events
            return cell // Return the configured cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 700 // // Set height for the row
        }
    }

