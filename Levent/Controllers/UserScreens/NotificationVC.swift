//
//  UserNotificationsVC.swift
//  Levent
//
//  Created by Fatema Albaqali on 20/12/2024.
//

import UIKit
class NotificationVC: UIViewController {
    
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var ticketsListTableView: UITableView!
    var ticketList: [TicketModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.dropShadow()
        ticketsListTableView.delegate = self
        ticketsListTableView.dataSource = self
        ticketsListTableView.rowHeight = 120
        
        ticketsListTableView.register(UINib(nibName: "NotificationsXibTableView", bundle: nil), forCellReuseIdentifier: "NotificationsXibTableView")
        
        fetchUserTickets()
        
    }
    
    private func fetchUserTickets() {
        // Get the logged-in user's email from UserSessionManager
        guard let userEmail = UserSessionManager.shared.getLoggedInUserEmail() else {
            print("No logged-in user email found.")
            showAlert(message: "Failed to fetch tickets. Please log in again.")
            return
        }
        
        // Show a loader while fetching tickets
        LoaderView.shared.show()
        
        // Fetch tickets using UserFeatures
        let userFeatures = UserFeatures()
        userFeatures.fetchUserTickets(forEmail: userEmail) { [weak self] tickets, error in
            LoaderView.shared.hide()
            
            if let error = error {
                print("Error fetching tickets: \(error.localizedDescription)")
                self?.showAlert(message: "Failed to fetch tickets: \(error.localizedDescription)")
                return
            }
            
            // Assign fetched tickets to the ticketList and reload the table view
            self?.ticketList = tickets ?? []
            print("Fetched \(self?.ticketList.count ?? 0) tickets.")
            self?.ticketsListTableView.reloadData()
        }
    }
    
}

// MARK: - UITableViewDelegate
extension NotificationVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
}

// MARK: - UITableViewDataSource
extension NotificationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsXibTableView", for: indexPath) as! NotificationsXibTableView
        cell.addCellDatawithTicketData(ticketModel: ticketList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
