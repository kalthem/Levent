

import UIKit
class EventReviewsXibTableView: UITableViewCell {
    
    
    @IBOutlet weak var xibView: UIView!
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var reviewrName: UILabel!
    @IBOutlet weak var reviewStarImage1: UIImageView!
    @IBOutlet weak var reviewStarImage2: UIImageView!
    @IBOutlet weak var reviewStarImage3: UIImageView!
    @IBOutlet weak var reviewStarImage4: UIImageView!
    @IBOutlet weak var reviewStarImage5: UIImageView!
    @IBOutlet weak var reviewData: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyCornerRadiusAndShadow(to: xibView)
        applyCornerRadiusAndShadow(to: reviewView)
    }
    
    func addCellDatawithReviewData(ratingReviewModel: EventModel.RatingReview) {
        reviewrName.text = ratingReviewModel.reviewerName
        reviewData.text = ratingReviewModel.review
        
        // Update star images based on rating
        let starImages = [reviewStarImage1, reviewStarImage2, reviewStarImage3, reviewStarImage4, reviewStarImage5]
        for (index, imageView) in starImages.enumerated() {
            if index < ratingReviewModel.rating {
                imageView?.image = UIImage(named: "starFilledImage") // Replace with the actual name of your filled star image
            } else {
                imageView?.image = UIImage(named: "starUnfilledImage") // Replace with the actual name of your unfilled star image
            }
        }
        
    }
    
    private func applyCornerRadiusAndShadow(to view: UIView, cornerRadius: CGFloat = 10, shadowRadius: CGFloat = 5, shadowOpacity: Float = 0.3, shadowColor: UIColor = .black, shadowOffset: CGSize = CGSize(width: 0, height: 3)) {
        // Corner radius
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = false

        // Shadow
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOffset = shadowOffset
    }
}
