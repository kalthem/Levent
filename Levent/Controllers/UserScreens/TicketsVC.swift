//
//  TicketsVC.swift
//  Levent
//
//  Created by Fatema Albaqali on 20/12/2024.
//

import UIKit

class TicketsVC: UIViewController{
    
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var ticketsTableView: UITableView!
    
    private var ticketList: [TicketModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.dropShadow()
        ticketsTableView.delegate = self
        ticketsTableView.dataSource = self
        ticketsTableView.rowHeight = 180
        
        ticketsTableView.register(UINib(nibName: "TicketsCell", bundle: nil), forCellReuseIdentifier: "TicketsCell")
        
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
            self?.ticketsTableView.reloadData()
        }
    }
    
    
}


// MARK: - UITableViewDelegate
extension TicketsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let boughtTicketsDetailsVC: BoughtTicketsDetailsVC = BoughtTicketsDetailsVC.instantiate(appStoryboard: .tickets)
        boughtTicketsDetailsVC.ticketDetails = ticketList[indexPath.row]
        navigationController?.pushViewController(boughtTicketsDetailsVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension TicketsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketsCell", for: indexPath) as! TicketsCell
        cell.addCellDatawithTicketData(ticketModel: ticketList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
