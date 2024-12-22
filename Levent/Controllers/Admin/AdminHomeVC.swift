//
//  AdminHomeVC.swift
//  Levent
//
//   Created by Yusuf M on 9/12/2024.
//

import UIKit
class AdminHomeVC: UIViewController {
    
    
    @IBOutlet weak var organizersListTableView: UITableView!
    var organizersList: [OrganizerModel] = []
    
    @IBOutlet weak var searchOrganizersTextField: CustomTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup table view
        organizersListTableView.delegate = self
        organizersListTableView.dataSource = self
        organizersListTableView.register(UINib(nibName: "AdminAllOrganizersXibTableView", bundle: nil), forCellReuseIdentifier: "AdminAllOrganizersXibTableView")
        organizersListTableView.rowHeight = 150
        // Fetch all organizers initially
        fetchAllOrganizers()
        
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let searchText = searchOrganizersTextField.text, !searchText.isEmpty else {
            // If search field is empty, load all organizers
            fetchAllOrganizers()
            return
        }

        // Fetch organizers by name
        searchOrganizers(withName: searchText)
    }
    
    private func fetchAllOrganizers() {
        LoaderView.shared.show()
        AdminFeatures().getOrganizersList { [weak self] organizers, error in
            LoaderView.shared.hide()
            guard let self = self else { return }
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
            } else {
                self.organizersList = organizers
                self.organizersListTableView.reloadData()
            }
        }
    }
    
    private func searchOrganizers(withName name: String) {
        LoaderView.shared.show()
        AdminFeatures().searchOrganizers(byName: name) { [weak self] organizers, error in
            LoaderView.shared.hide()
            guard let self = self else { return }
            if let error = error {
                self.showAlert(title: "Error", message: error.localizedDescription)
            } else {
                self.organizersList = organizers
                self.organizersListTableView.reloadData()
            }
        }
    }
    
}

extension AdminHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizersList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdminAllOrganizersXibTableView", for: indexPath) as? AdminAllOrganizersXibTableView else {
            return UITableViewCell()
        }
        let organizer = organizersList[indexPath.row]
        cell.configure(organierModel: organizer)
        cell.delegate = self// Assuming configure method exists in your XIB cell
        return cell
    }
}

extension AdminHomeVC: AdminAllOrganizersXibTableViewDelegate {
    func deleteOrganizer(cell: AdminAllOrganizersXibTableView) {
        guard let indexPath = organizersListTableView.indexPath(for: cell) else { return }
        let organizer = organizersList[indexPath.row]
        
        // Show confirmation alert
        showConfirmationAlert(
            title: "Delete Organizer",
            message: "Do you wish to delete the organizer and all events created by the organizer?",
            confirmTitle: "Delete",
            cancelTitle: "Cancel"
        ) { [weak self] in
            guard let self = self else { return }
            
            LoaderView.shared.show()
            AdminFeatures().deleteOrganizer(organizerEmail: organizer.email) { error in
                LoaderView.shared.hide()
                if let error = error {
                    self.showAlert(message: "Failed to delete organizer: \(error.localizedDescription)")
                } else {
                    self.showAlert(message: "Organizer and their events deleted successfully!") {
                        // Remove the deleted organizer from the list and reload table
                        self.organizersList.remove(at: indexPath.row)
                        self.organizersListTableView.reloadData()
                    }
                }
            }
        }
    }

    
    func showOrganizerDetails(cell: AdminAllOrganizersXibTableView) {
        print("details Pressed")
        guard let indexPath = organizersListTableView.indexPath(for: cell) else { return }
        let organizer = organizersList[indexPath.row]
        let organizerDetailsVC: OrganizerDetailsVC = OrganizerDetailsVC.instantiate(appStoryboard: .admin)
        organizerDetailsVC.email = organizer.email
        navigationController?.pushViewController(organizerDetailsVC, animated: true)
    }
}

