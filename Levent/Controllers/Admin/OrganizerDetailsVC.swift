//
//  OrganizerDetailsVC.swift
//  Levent
//
//   Created by Yusuf M on 9/12/2024.
//

import UIKit
class OrganizerDetailsVC: UIViewController {
    
    var email: String?
    var organizerDetails: OrganizerModel?
    @IBOutlet weak var organizerName: UILabel!
    @IBOutlet weak var organizerEmail: UILabel!
    @IBOutlet weak var organizerPhoneNumber: UILabel!
    
    
    @IBOutlet weak var organizerEventsListTableView: UITableView!
    
    var eventsList: [EventModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup table view
        organizerEventsListTableView.delegate = self
        organizerEventsListTableView.dataSource = self
        navigationItem.hidesBackButton = true
        organizerEventsListTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        // Fetch Organizer and Events
        fetchOrganizerDetails()
        
    }
    
    
    @IBAction func editOrganizerButtonPressed(_ sender: Any) {
        let editOrgaznierVC: EditOrganizerVC = EditOrganizerVC.instantiate(appStoryboard: .admin)
        editOrgaznierVC.organizerDetails = self.organizerDetails
        navigationController?.pushViewController(editOrgaznierVC, animated: true)
    }
    
    private func fetchOrganizerDetails() {
        guard let email = email else {
            self.showAlert(title: "Error", message: "No email provided for fetching organizer details.")
            return
        }
        
        LoaderView.shared.show()
        AdminFeatures().getOrganizer(byEmail: email) { [weak self] organizer, error in
            LoaderView.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(title: "Error", message: "Failed to fetch organizer: \(error.localizedDescription)")
            } else if let organizer = organizer {
                // Populate organizer details
                self.organizerDetails = organizer
                self.organizerName.text = organizer.name
                self.organizerEmail.text = organizer.email
                self.organizerPhoneNumber.text = organizer.contact
                
                // Fetch organizer's events
                self.fetchOrganizerEvents(email: organizer.email)
            }
        }
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
                    self.organizerEventsListTableView.reloadData()
                }
            }
        }
}

extension OrganizerDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell) else {
            return UITableViewCell()
        }
        let event = eventsList[indexPath.row]
        cell.addCellDatawithEventData(eventModel: event) // Assuming configure method exists in your XIB cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the selected row
        tableView.deselectRow(at: indexPath, animated: true)
        // Get the selected event
        let selectedEvent = eventsList[indexPath.row]
        
        let organizerEventDetailsVC: OrganizerEventDetailsVC = OrganizerEventDetailsVC.instantiate(appStoryboard: .organizer)
        organizerEventDetailsVC.eventDetails = selectedEvent
        organizerEventDetailsVC.isOrganizer = false
        navigationController?.pushViewController(organizerEventDetailsVC, animated: true)
    }
}
