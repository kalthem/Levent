//
//  PersonalizeViewController.swift
//  Levent
//
//  Created by k 3 on 06/12/2024.
//

import UIKit

class RecommendationsViewController: UIViewController {
   
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var ThirdImageView: UIImageView!
    @IBOutlet weak var fourthImageView: UIImageView!
    @IBOutlet weak var fifthImageView: UIImageView!
    
    // Mock images stored in a dictionary
        let interestImages: [Interest: [UIImage]] = [
            .communityAndSocial: [UIImage(named: "community1")!],
            .sportsAndFitness: [UIImage(named: "sports1")!],
            .techAndInnovation: [UIImage(named: "tech1")!],
            .music: [UIImage(named: "music1")!],
            .artAndCulture: [UIImage(named: "art1")!]
        ]
    var selectedInterests: Set<Interest> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recommendations"
        loadUserInterests()
                displayImages()
            }
            
            private func loadUserInterests() {
                if let user = JSONStorage.shared.loadUser(), let interests = user.interests {
                    selectedInterests = Set(interests)
                }
            }
            
            private func displayImages() {
                var imagesToShow: [UIImage] = []
                
                // Collect images based on selected interests
                for interest in selectedInterests {
                    if let images = interestImages[interest] {
                        imagesToShow.append(contentsOf: images)
                    }
                    
                }
                
                // Display the first two images if available
                if imagesToShow.count > 0 {
                    firstImageView?.image = imagesToShow[0]
                }
                if imagesToShow.count > 1 {
                    secondImageView?.image = imagesToShow[1]
                }
                
                if imagesToShow.count > 2 {
                    ThirdImageView?.image = imagesToShow[2]
                }
                
                if imagesToShow.count > 3 {
                    fourthImageView?.image = imagesToShow[3]
                }
                if imagesToShow.count > 4 {
                    fifthImageView?.image = imagesToShow[4]
                }
            }
   
}
