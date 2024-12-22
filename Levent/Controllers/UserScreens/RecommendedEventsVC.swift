

import UIKit
class RecommendedEventsVC: UIViewController{
    
    
    @IBOutlet weak var recommendListTableView: UITableView!
    var recommendedEventsList: [EventModel] = []
    
    
    @IBOutlet weak var shadowView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupTableView()
        recommendListTableView.reloadData()
        shadowView.dropShadow()
    }
    
    private func setupTableView() {
        recommendListTableView.delegate = self
        recommendListTableView.dataSource = self
        recommendListTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        recommendListTableView.rowHeight = 200
    }
    
    
}

extension RecommendedEventsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventDetailsVC: EventDetailsVC = EventDetailsVC.instantiate(appStoryboard: .user)
        eventDetailsVC.eventData = recommendedEventsList[indexPath.row]
        navigationController?.pushViewController(eventDetailsVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension RecommendedEventsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendedEventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        cell.addCellDatawithEventData(eventModel: recommendedEventsList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
