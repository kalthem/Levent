import UIKit

class UserHomeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mainEventsCollectionView: UICollectionView!
    @IBOutlet weak var recommendationsCollectionView: UICollectionView!
    @IBOutlet weak var mainEventsPageControl: UIPageControl!
    @IBOutlet weak var recommendationsPageControl: UIPageControl!
    @IBOutlet weak var tabBar: UITabBar!

    // MARK: - Properties
    private var mainEvents: [Event] = []
    private var recommendedEvents: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

    // MARK: - UI Setup
    private func setupUI() {
        // Configure Navigation Bar
        navigationItem.title = "Homepage"

        let notificationsButton = UIBarButtonItem(
            image: UIImage(systemName: "bell"),
            style: .plain,
            target: self,
            action: #selector(notificationsTapped)
        )
        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(profileTapped)
        )
        navigationItem.leftBarButtonItem = notificationsButton
        navigationItem.rightBarButtonItem = profileButton

        // Register cells
        mainEventsCollectionView.register(
            UINib(nibName: "MainEventCell", bundle: nil),
            forCellWithReuseIdentifier: "MainEventCell"
        )
        recommendationsCollectionView.register(
            UINib(nibName: "RecommendationCell", bundle: nil),
            forCellWithReuseIdentifier: "RecommendationCell"
        )

        // Set delegates and data sources
        mainEventsCollectionView.delegate = self
        mainEventsCollectionView.dataSource = self
        recommendationsCollectionView.delegate = self
        recommendationsCollectionView.dataSource = self

        // Configure Tab Bar
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?.first // Select "Home" by default
    }

    // MARK: - Data Loading
    private func loadData() {
        let events = DataStorage.shared.load([Event].self, from: "events.json")

        // Top 3 events by tickets sold
        mainEvents = events.sorted(by: { $0.ticketsSold > $1.ticketsSold }).prefix(3).map { $0 }

        // Recommendations based on user's interests
        if let user = DataStorage.shared.getCurrentUser(),
           let interests = user.interests {
            recommendedEvents = events.filter { interests.contains($0.artistName) }
        }

        mainEventsCollectionView.reloadData()
        recommendationsCollectionView.reloadData()

        // Configure page controls
        mainEventsPageControl.numberOfPages = mainEvents.count
        recommendationsPageControl.numberOfPages = recommendedEvents.count
    }

    // MARK: - Actions
    @objc private func notificationsTapped() {
        navigateToStoryboard(named: "Notifications")
    }

    @objc private func profileTapped() {
        navigateToStoryboard(named: "Profile")
    }

    @IBAction func mainEventsSeeMoreTapped(_ sender: UIButton) {
        navigateToStoryboard(named: "MainEventsScreen")
    }

    @IBAction func recommendationsSeeMoreTapped(_ sender: UIButton) {
        navigateToStoryboard(named: "RecommendedEventsScreen")
    }
}

// MARK: - Tab Bar Action Handling
extension UserHomeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title {
        case "Tickets":
            navigateToStoryboard(named: "Tickets")
        case "Explore":
            navigateToStoryboard(named: "Explore")
        default:
            break
        }
    }
}

// MARK: - Collection View Delegate & Data Source
extension UserHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == mainEventsCollectionView ? mainEvents.count : recommendedEvents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainEventsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainEventCell", for: indexPath) as! MainEventCell
            cell.configure(with: mainEvents[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath) as! RecommendationCell
            cell.configure(with: recommendedEvents[indexPath.row])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = collectionView == mainEventsCollectionView ? mainEvents[indexPath.row] : recommendedEvents[indexPath.row]

        if let eventDetailsVC = UIStoryboard(name: "EventDetails", bundle: nil).instantiateInitialViewController() as? EventDetailsViewController {
            eventDetailsVC.event = event
            navigationController?.pushViewController(eventDetailsVC, animated: true)
        }
    }
}

// MARK: - Scroll View Delegate for Page Control
extension UserHomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == mainEventsCollectionView {
            mainEventsPageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        } else if scrollView == recommendationsCollectionView {
            recommendationsPageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        }
    }
}
