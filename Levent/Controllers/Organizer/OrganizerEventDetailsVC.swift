
import UIKit
class OrganizerEventDetailsVC: UIViewController {
    
    var eventDetails: EventModel?
    var isOrganizer: Bool?
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventImageUrl: UIImageView!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventName2: UILabel!
    @IBOutlet weak var eventHost: UILabel!
    @IBOutlet weak var eventTicketPrice: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    
    @IBOutlet weak var eventReviewsListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEventDetails()
        setupTableView()
        navigationItem.hidesBackButton = true
        
    }
    
    private func setupEventDetails() {
        guard let event = eventDetails else { return }
        
        eventName.text = event.eventName
        eventName2.text = event.eventName
        eventHost.text = event.organizerName
        eventTicketPrice.text = "$\(event.eventTicketPrice)"
        eventLocation.text = event.eventLocation
        eventDate.text = "\(event.eventDate) at \(event.eventTime)"
        eventImageUrl.setImage(with: event.imageUrl)
    }
    
    private func setupTableView() {
        eventReviewsListTableView.delegate = self
        eventReviewsListTableView.dataSource = self
        eventReviewsListTableView.register(UINib(nibName: "EventReviewsXibTableView", bundle: nil), forCellReuseIdentifier: "EventReviewsXibTableView")
        eventReviewsListTableView.rowHeight = 150
    }
    
    @IBAction func editEventButtonPresed(_ sender: Any) {
        let editEventVC: EditEventVC = EditEventVC.instantiate(appStoryboard: .organizer)
        editEventVC.eventDetails = eventDetails
        editEventVC.isOrganizer = self.isOrganizer
        navigationController?.pushViewController(editEventVC, animated: true)
    }
    
    
    @IBAction func deleteEventButtonPressed(_ sender: Any) {
        showConfirmationAlert(
            title: "Delete Event",
            message: "Are you sure you want to delete this event?",
            confirmTitle: "Delete",
            cancelTitle: "Cancel"
        ) { [weak self] in
            guard let self = self, let eventDetails = self.eventDetails else { return }
            
            LoaderView.shared.show()
            OrganizerEventsFeatures().removeEvent(eventId: eventDetails.documentID) { error in
                LoaderView.shared.hide()
                if let error = error {
                    self.showAlert(message: "Failed to delete event: \(error.localizedDescription)")
                } else {
                    self.showAlert(message: "Event deleted successfully!") {
                        if self.isOrganizer == true {
                            let storyboard = UIStoryboard(name: "Organizer", bundle: nil)
                            if let adminViewController = storyboard.instantiateViewController(withIdentifier: "OrganizerTabBarVC") as? UITabBarController {
                                self.navigationController?.setViewControllers([adminViewController], animated: true) }
                            return
                        } else {
                            let storyboard = UIStoryboard(name: "Admin", bundle: nil)
                            if let adminViewController = storyboard.instantiateViewController(withIdentifier: "AdminTabBarVC") as? UITabBarController {
                                self.navigationController?.setViewControllers([adminViewController], animated: true) }
                            return
                        }
                    }
                }
            }
        }
    }
}


extension OrganizerEventDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventDetails?.ratingsAndReviews?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventReviewsXibTableView", for: indexPath) as? EventReviewsXibTableView,
              let review = eventDetails?.ratingsAndReviews?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.addCellDatawithReviewData(ratingReviewModel: review)
        return cell
    }
}

