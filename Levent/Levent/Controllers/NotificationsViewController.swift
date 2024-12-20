import UIKit

class NotificationsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    private let notifications = [
        "You have a new ticket for Concert X!",
        "Event Y has been updated!",
        "Your profile was successfully updated.",
        "Don’t miss the upcoming event Z!",
        "Thank you for your feedback!"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Notifications"

        // Register the cell
        collectionView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellWithReuseIdentifier: "NotificationCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Collection View Delegate & Data Source
extension NotificationsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notifications.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.configure(with: notifications[indexPath.row])
        return cell
    }
}

// MARK: - NotificationCell
class NotificationCell: UICollectionViewCell {
    @IBOutlet weak var notificationLabel: UILabel!

    func configure(with text: String) {
        notificationLabel.text = text
        notificationLabel.font = UIFont.systemFont(ofSize: 16)
        notificationLabel.textColor = .label
    }
}
