
import UIKit
class AddReviewVC: UIViewController {
    
    var ticketData: TicketModel?
    
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var reviewMessage: CustomTextField!
    @IBOutlet weak var reviewImage1: UIButton!
    @IBOutlet weak var reviewImage2: UIButton!
    @IBOutlet weak var reviewImage3: UIButton!
    @IBOutlet weak var reviewImage4: UIButton!
    @IBOutlet weak var reviewImage5: UIButton!
    
    private var selectedRating: Int = 0 // Default rating is 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.dropShadow()
        
    }
    
    // Update the star images based on selected rating
    private func updateRatingImages() {
        let allButtons = [reviewImage1, reviewImage2, reviewImage3, reviewImage4, reviewImage5]
        
        for (index, button) in allButtons.enumerated() {
            let image = index < selectedRating ? UIImage(named: "starFilledImage") : UIImage(named: "starUnfilledImage")
            button?.setImage(image, for: .normal)
        }
    }
    
    @IBAction func reviewImage1ButtonPressed(_ sender: Any) {
        selectedRating = 1
        updateRatingImages()
    }
    
    @IBAction func reviewImage2ButtonPressed(_ sender: Any) {
        selectedRating = 2
        updateRatingImages()
    }
    
    @IBAction func reviewImage3ButtonPressed(_ sender: Any) {
        selectedRating = 3
        updateRatingImages()
    }
    @IBAction func reviewImage4ButtonPressed(_ sender: Any) {
        selectedRating = 4
        updateRatingImages()
    }
    
    @IBAction func reviewImage5ButtonPressed(_ sender: Any) {
        selectedRating = 5
        updateRatingImages()
    }
    
    @IBAction func addReviewButtonPressed(_ sender: Any) {
        guard let ticket = ticketData else {
            showAlert(message: "Ticket data not available.")
            return
        }
        
        guard !reviewMessage.text!.isEmpty else {
            showAlert(message: "Review message cannot be empty.")
            return
        }
        
        guard selectedRating > 0 else {
            showAlert(message: "Please select a rating.")
            return
        }
        
        // Create the review
        let newReview = EventModel.RatingReview(reviewerName: ticket.buyerName, rating: selectedRating, review: reviewMessage.text ?? "")
        
        // Add the review using UserFeatures
        let userFeatures = UserFeatures()
        LoaderView.shared.show()
        userFeatures.addReview(toEvent: ticket.eventId, review: newReview) { [weak self] error in
            LoaderView.shared.hide()
            if let error = error {
                self?.showAlert(message: "Failed to add review: \(error.localizedDescription)")
            } else {
                self?.showAlert(message: "Review added successfully!"){
                    let storyboard = UIStoryboard(name: "UserScreens", bundle: nil)
                    if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeVCTabBar") as? UITabBarController {
                        self?.navigationController?.setViewControllers([homeViewController], animated: true)
                    }
                }
            }
        }
    }
}
