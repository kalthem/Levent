import UIKit

class RecommendationCell: UICollectionViewCell {
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventArtistLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!

    func configure(with event: Event) {
        eventNameLabel.text = event.name
        eventDateLabel.text = event.date
        eventArtistLabel.text = event.artistName
        if let imagePath = event.imagePath, let image = DataStorage.shared.loadImage(named: imagePath) {
            eventImageView.image = image
        }
    }
}


