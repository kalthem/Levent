

import UIKit
class SelectIntrestsVC: UIViewController {
    
    var selectedGender: String?
    var selectedDOB: String?
    var interests: [String] = []
    
    @IBOutlet weak var musicView: UIView!
    @IBOutlet weak var sportsView: UIView!
    @IBOutlet weak var artView: UIView!
    @IBOutlet weak var musicSelectorImage: UIImageView!
    @IBOutlet weak var sportsSelectorImage: UIImageView!
    @IBOutlet weak var artsSelectorImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
    }
    
    @IBAction func musicButtonPressed(_ sender: Any) {
        toggleInterest("Music", imageView: musicSelectorImage)
    }
    
    @IBAction func artButtonPresed(_ sender: Any) {
        toggleInterest("Art", imageView: artsSelectorImage)
    }
    @IBAction func SportsButtonPressed(_ sender: Any) {
        toggleInterest("Sports", imageView: sportsSelectorImage)
    }
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if interests.isEmpty {
            showAlert(message: "Please select at least one interest before continuing.")
            return
        }
        let termsAndConditionsVC: TermsAndConditionsVC = TermsAndConditionsVC.instantiate(appStoryboard: .accountSetup)
        termsAndConditionsVC.selectedGender = selectedGender
        termsAndConditionsVC.selectedDOB = selectedDOB
        termsAndConditionsVC.interests = interests
        navigationController?.pushViewController(termsAndConditionsVC, animated: true)
        
        
    }
    
    private func toggleInterest(_ interest: String, imageView: UIImageView) {
        if interests.contains(interest) {
            // Deselect
            interests.removeAll { $0 == interest }
            imageView.image = UIImage(named: "emptyCheckBoxImage")
        } else {
            // Select
            interests.append(interest)
            imageView.image = UIImage(named: "filledCheckBoxImage")
        }
    }
}

