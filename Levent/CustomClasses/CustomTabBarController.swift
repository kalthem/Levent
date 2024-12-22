import UIKit

class CustomTabBarController: UITabBarController {

    let ticketButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAddButton()
        customizeTabBar()
    }

    func setupAddButton() {
        // Set up the button with the desired properties
        ticketButton.setImage(UIImage(named: "ticketsImage"), for: .normal)
        ticketButton.contentMode = .scaleAspectFit
        ticketButton.backgroundColor = .clear
        ticketButton.layer.cornerRadius = 32
        ticketButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        // Add the button to the view, but don't alter the tab bar itself
        self.view.addSubview(ticketButton)

        // Constraints to center the button on the tab bar
        ticketButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ticketButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            ticketButton.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: 29),
            ticketButton.widthAnchor.constraint(equalToConstant: 64),
            ticketButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }

    func customizeTabBar() {
        
        tabBar.barTintColor = .appBlue
        
        // Set a prominent shadow for the top of the tab bar to separate it from the above screen
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -6) // Slightly bigger offset for more shadow
        self.tabBar.layer.shadowOpacity = 0.4 // Increased opacity for a more visible shadow
        self.tabBar.layer.shadowRadius = 6 // Increased radius for a larger shadow blur effect
        self.tabBar.layer.masksToBounds = false
        
        
        // Set the background color of the tab bar to grey
        tabBar.barTintColor = .appBlue

        
        // Set the tintColor for the entire tabBar (applies to all items)
        tabBar.tintColor = .appBlue
        
        // Apply custom color for specific items (1 and 2)
        if let items = tabBar.items {
            if items.count > 1 {
                let item1 = items[1]
                item1.image = item1.image?.withRenderingMode(.alwaysTemplate)
                item1.selectedImage = item1.selectedImage?.withRenderingMode(.alwaysTemplate)
            }
            if items.count > 2 {
                let item2 = items[2]
                item2.image = item2.image?.withRenderingMode(.alwaysTemplate)
                item2.selectedImage = item2.selectedImage?.withRenderingMode(.alwaysTemplate)
            }
        }
    }

    @objc func addButtonTapped() {
        let ticketsVC: TicketsVC = TicketsVC.instantiate(appStoryboard: .tickets) // Replace with your actual view controller
        self.navigationController?.pushViewController(ticketsVC, animated: true)
    }
}
