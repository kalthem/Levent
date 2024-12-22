import UIKit

class HomeVC: UIViewController {

    private var allEvents: [EventModel] = []
    private var interestEvents: [EventModel] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add shadow effect to the view
        addBottomShadow()
        navigationController?.isNavigationBarHidden = true

        // Register the custom cell
        eventCollectionView.register(UINib(nibName: "EventCell", bundle: nil), forCellWithReuseIdentifier: "EventCell")
        recommendedEventCollectionView.register(UINib(nibName: "EventCell", bundle: nil), forCellWithReuseIdentifier: "EventCell")
        
        // Set the background color to transparent
        eventCollectionView.layer.backgroundColor = UIColor.clear.cgColor
        recommendedEventCollectionView.layer.backgroundColor = UIColor.clear.cgColor
        
        // Set line spacing for collection views
        (eventCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 10
        (recommendedEventCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 10
        
        // Fetch events
        // Fetch events
        fetchAllEvents()
        fetchInterestBasedEvents()
    }
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var recommendedEventCollectionView: UICollectionView!
    
    
    
    @IBAction func profileButtonPressed(_ sender: Any) {
        let userProfileVC: UserProfileVC = UserProfileVC.instantiate(appStoryboard: .user)
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
    
    @IBAction func firstSeeMorePressed(_ sender: Any) {
        let mainEventsVC: MainEventsVC = MainEventsVC.instantiate(appStoryboard: .user)
        self.navigationController?.pushViewController(mainEventsVC, animated: true)
    }
    
    @IBAction func secondSeeMorePressed(_ sender: Any) {
        let recommendedEventsVC: RecommendedEventsVC = RecommendedEventsVC.instantiate(appStoryboard: .user)
        recommendedEventsVC.recommendedEventsList = interestEvents
        self.navigationController?.pushViewController(recommendedEventsVC, animated: true)
    }
    
    func addBottomShadow() {
        shadowView.dropShadow()
    }
    
    
    private func fetchAllEvents() {
        LoaderView.shared.show()
        let userFeatures = UserFeatures()

        userFeatures.fetchAllEvents { [weak self] allEvents, error in
            if let error = error {
                self?.showAlert(message: "Failed to fetch all events: \(error.localizedDescription)")
            } else {
                self?.allEvents = allEvents ?? []
                self?.eventCollectionView.reloadData()
            }
            LoaderView.shared.hide() // Hide loader after fetching all events
        }
    }


    private func fetchInterestBasedEvents() {
        let loggedInUserInterests = UserSessionManager.shared.getLoggedInUserInterests()

        guard !loggedInUserInterests.isEmpty else {
            print("No interests found for the logged-in user.")
            showAlert(message: "No interests found for the logged-in user.")
            return
        }

        print("Logged-in user interests: \(loggedInUserInterests)")

        LoaderView.shared.show()
        let userFeatures = UserFeatures()
        
        userFeatures.fetchInterestEvents(forInterests: loggedInUserInterests) { [weak self] interestEvents, error in
            if let error = error {
                self?.showAlert(message: "Failed to fetch interest-based events: \(error.localizedDescription)")
            } else {
                self?.interestEvents = interestEvents ?? []
                print("Fetched \(self?.interestEvents.count ?? 0) interest-based events.")
                self?.recommendedEventCollectionView.reloadData()
            }
            LoaderView.shared.hide() // Hide loader after fetching interest-based events
        }
    }


    
}

// MARK: - UICollectionViewDelegate and UICollectionViewDataSource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == eventCollectionView {
            return allEvents.count
        } else {
            return interestEvents.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath as IndexPath) as! EventCell
        let event = collectionView == eventCollectionView ? allEvents[indexPath.row] : interestEvents[indexPath.row]
        cell.addCellDatawithEventData(eventModel: event)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedEvent: EventModel

        if collectionView == eventCollectionView {
            // Selection from all events
            selectedEvent = allEvents[indexPath.row]
        } else if collectionView == recommendedEventCollectionView {
            // Selection from interest-based events
            selectedEvent = interestEvents[indexPath.row]
        } else {
            return // Just in case an unexpected collectionView is passed
        }
        
        let eventDetailsVC: EventDetailsVC = EventDetailsVC.instantiate(appStoryboard: .user)
        eventDetailsVC.eventData = selectedEvent // Pass the selected event
        navigationController?.pushViewController(eventDetailsVC, animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == eventCollectionView {
            return CGSize(width: 200, height: 220) // Customize the size of your cell
        } else {
            return CGSize(width: 150, height: 220) // Halve the width for recommended events
        }
    }
}
