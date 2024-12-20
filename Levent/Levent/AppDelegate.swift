import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        preloadData()
        
        
        return true
    }

    private func preloadData() {
        let users = [
            User(
                id: UUID().uuidString,
                name: "John Doe",
                email: "john.doe@example.com",
                password: "password123",
                isOrganizer: false,
                gender: "Male",
                interests: ["Concerts"]
            ),
            User(
                id: UUID().uuidString,
                name: "Jane Organizer",
                email: "jane.organizer@example.com",
                password: "password123",
                isOrganizer: true,
                gender: nil,
                interests: nil
            )
        ]


        let exampleImage = UIImage(named: "Logo")!
        let exampleImagePath = DataStorage.shared.saveImage(exampleImage, withName: "exampleImage.jpg")

         let events = [
             Event(
                 id: UUID().uuidString,
                 name: "Concert in the Park",
                 artistName: "The Weeknd",
                 location: "Central Park, NYC",
                 date: "2024-12-25",
                 ticketPrice: 50.0,
                 ticketsSold: 20,
                 totalTickets: 100,
                 organizerId: "someOrganizerId",
                 comments: [],
                 imagePath: exampleImagePath
             )
         ]

        // Save to local storage
        DataStorage.shared.save(users, to: "users.json")
        DataStorage.shared.save(events, to: "events.json")

    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
