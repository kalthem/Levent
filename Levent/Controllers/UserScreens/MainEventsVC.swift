

import UIKit
class MainEventsVC: UIViewController {
    
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var searchBar: CustomTextField!
    
    private var eventsList : [EventModel] = []
    private var filteredEventsList: [EventModel] = []
    private var searchedEventsList: [EventModel] = []
    private var isSearching: Bool {
        return !(searchBar.text?.isEmpty ?? true)
    }
    
    private var selectedCategory: String = "All"
    private var selectedTimeFilter: String = "All Times"
    
    override func viewDidLoad() {
        shadowView.dropShadow()
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true

        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        eventsTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        eventsTableView.rowHeight = 200
        searchBar.addTarget(self, action: #selector(searchEvents), for: .editingChanged)
        // Initialize search
        //searchBar.addTarget(self, action: #selector(searchEvents), for: .editingChanged)
        fetchAllEvents()
    }
    
    @objc private func searchEvents() {
        let query = searchBar.text?.lowercased() ?? ""
        if query.isEmpty {
            // If search field is empty, clear searchedEventsList
            searchedEventsList = []
        } else {
            // Filter data from filteredEventsList based on the query
            searchedEventsList = filteredEventsList.filter {
                $0.eventName.lowercased().contains(query) || $0.eventCategory.lowercased().contains(query)
            }
        }
        eventsTableView.reloadData()
    }
    
    private func fetchAllEvents() {
        LoaderView.shared.show()
        let userFeatures = UserFeatures()

        userFeatures.fetchAllEvents { [weak self] allEvents, error in
            if let error = error {
                self?.showAlert(message: "Failed to fetch all events: \(error.localizedDescription)")
            } else {
                self?.eventsList = allEvents ?? []
                self?.filteredEventsList = self!.eventsList // Initially show all events
                self?.eventsTableView.reloadData()
            }
            LoaderView.shared.hide() // Hide loader after fetching all events
        }
    }
    
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        showFilterPopup()
    }
}

extension MainEventsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventDetailsVC: EventDetailsVC = EventDetailsVC.instantiate(appStoryboard: .user)
        eventDetailsVC.eventData = filteredEventsList[indexPath.row]
        navigationController?.pushViewController(eventDetailsVC, animated: true)
    }
    
    
}

extension MainEventsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? searchedEventsList.count : filteredEventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        let event = isSearching ? searchedEventsList[indexPath.row] : filteredEventsList[indexPath.row]
        cell.addCellDatawithEventData(eventModel: event)
        cell.selectionStyle = .none
        return cell
    }
}


extension MainEventsVC {

    private var filterPopupView: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.filterPopupView) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.filterPopupView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private struct AssociatedKeys {
        static var filterPopupView = "filterPopupView"
    }

    private func parseDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy" // Match your stored format
        return dateFormatter.date(from: dateString)
    }

    func showFilterPopup() {
        let filterView = UIView()
        filterView.backgroundColor = .white
        filterView.layer.cornerRadius = 16
        filterView.layer.masksToBounds = true
        filterPopupView = filterView

        // Setup categories
        let categories = ["All", "Music", "Sports", "Art"]
        let categoryStackView = createFilterButtons(with: categories, action: #selector(categoryFilterSelected))

        // Setup time filters
        let timeFilters = ["All Times", "This Week", "Today"]
        let timeStackView = createFilterButtons(with: timeFilters, action: #selector(timeFilterSelected))

        // Setup "Apply Filter" button
        let applyButton = UIButton(type: .system)
        applyButton.setTitle("Apply Filter", for: .normal)
        applyButton.backgroundColor = .appBlue // Always blue background
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.layer.cornerRadius = 8
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)

        // Layout filter view
        let stackView = UIStackView(arrangedSubviews: [categoryStackView, timeStackView, applyButton])
        stackView.axis = .vertical
        stackView.spacing = 16

        filterView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: filterView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: filterView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: filterView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: filterView.bottomAnchor, constant: -16),
            applyButton.heightAnchor.constraint(equalToConstant: 50) // Consistent height for "Apply Filter"
        ])

        // Present popup
        filterView.frame = CGRect(x: 20, y: self.view.frame.height / 3, width: self.view.frame.width - 40, height: 200)
        self.view.addSubview(filterView)
    }

    private func createFilterButtons(with titles: [String], action: Selector) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually

        for title in titles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 8
            button.layer.borderColor = UIColor.appBlue.cgColor // appBlue border
            button.backgroundColor = title == selectedCategory || title == selectedTimeFilter ? .appBlue : .white
            button.setTitleColor(title == selectedCategory || title == selectedTimeFilter ? .white : .black, for: .normal)
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true // Consistent height for all buttons
            button.addTarget(self, action: action, for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }

        return stackView
    }

    @objc private func categoryFilterSelected(_ sender: UIButton) {
        selectedCategory = sender.currentTitle ?? "All"
        refreshFilterButtons()
    }

    @objc private func timeFilterSelected(_ sender: UIButton) {
        selectedTimeFilter = sender.currentTitle ?? "All Times"
        refreshFilterButtons()
    }

    private func refreshFilterButtons() {
        filterPopupView?.subviews.forEach { view in
            if let stackView = view as? UIStackView {
                stackView.arrangedSubviews.forEach { subview in
                    if let button = subview as? UIButton, button.title(for: .normal) != "Apply Filter" {
                        let title = button.currentTitle ?? ""
                        let isSelected = title == selectedCategory || title == selectedTimeFilter
                        button.backgroundColor = isSelected ? .appBlue : .white
                        button.setTitleColor(isSelected ? .white : .black, for: .normal)
                        button.layer.borderColor = UIColor.appBlue.cgColor // Maintain appBlue border
                    }
                }
            }
        }
    }


    @objc private func applyFilters() {
        filteredEventsList = eventsList.filter { event in
            applyCategoryFilter(event: event) && applyTimeFilter(event: event)
        }
        eventsTableView.reloadData()
        filterPopupView?.removeFromSuperview() // Dismiss popup
    }

    private func applyCategoryFilter(event: EventModel) -> Bool {
        return selectedCategory == "All" || event.eventCategory == selectedCategory
    }

    private func applyTimeFilter(event: EventModel) -> Bool {
        guard let eventDate = parseDate(from: event.eventDate) else { return false }
        let now = Date()
        switch selectedTimeFilter {
        case "Today":
            return Calendar.current.isDateInToday(eventDate)
        case "This Week":
            return Calendar.current.isDate(eventDate, equalTo: now, toGranularity: .weekOfYear)
        default:
            return true // "All Times" or no filter
        }
    }
}



