
import UIKit
class OrganizerHomeVC: UIViewController {
    
    @IBOutlet weak var searchEventsTextField: CustomTextField!
    
    @IBOutlet weak var eventsListTableView: UITableView!
    
    var eventsList: [EventModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsListTableView.delegate = self
        eventsListTableView.dataSource = self
        eventsListTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        if let organizerEmail = UserSessionManager.shared.getLoggedInUserEmail() {
            fetchOrganizerEvents(email: organizerEmail)
        }
        return
        
    }
    
    private func fetchOrganizerEvents(email: String) {
        LoaderView.shared.show()
        OrganizerEventsFeatures().fetchOrganizerEvents(organizerEmail: email) { [weak self] events, error in
            LoaderView.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(title: "Error", message: "Failed to fetch events: \(error.localizedDescription)")
            } else {
                self.eventsList = events ?? []
                self.eventsListTableView.reloadData()
            }
        }
    }
    
    private func searchEvents(byName name: String) {
           LoaderView.shared.show()
        let organizerEmail = UserSessionManager.shared.getLoggedInUserEmail() ?? ""
        OrganizerEventsFeatures().searchEvents(byName: name, organizerEmail: organizerEmail) { [weak self] events, error in
               LoaderView.shared.hide()
               guard let self = self else { return }
               
               if let error = error {
                   self.showAlert(title: "Error", message: "Failed to search events: \(error.localizedDescription)")
               } else {
                   self.eventsList = events ?? []
                   self.eventsListTableView.reloadData()
               }
           }
       }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let searchText = searchEventsTextField.text, !searchText.isEmpty else {
            // Fetch all events if search text is empty
            if let organizerEmail = UserSessionManager.shared.getLoggedInUserEmail() {
                fetchOrganizerEvents(email: organizerEmail)
            }
            return
        }
        
        // Search for events by name
        searchEvents(byName: searchText)
    }
}


extension OrganizerHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell) else {
            return UITableViewCell()
        }
        let event = eventsList[indexPath.row]
        cell.addCellDatawithEventData(eventModel: event) // Assuming configure method exists in your XIB cell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the selected row
        tableView.deselectRow(at: indexPath, animated: true)

        // Get the selected event
        let selectedEvent = eventsList[indexPath.row]
    
        let organizerEventDetailsVC: OrganizerEventDetailsVC = OrganizerEventDetailsVC.instantiate(appStoryboard: .organizer)
        organizerEventDetailsVC.eventDetails = selectedEvent
        organizerEventDetailsVC.isOrganizer = true
        navigationController?.pushViewController(organizerEventDetailsVC, animated: true)
    }

    
}
