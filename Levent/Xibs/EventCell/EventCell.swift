//
//  EventCell.swift
//  Levent
//
//   Created by Yusuf M on 9/12/2024.
//

import UIKit
import SDWebImage

class EventCell: UICollectionViewCell {
    
    
    @IBOutlet weak var mainView: UIView!
    
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var eventDate: UILabel!
    
    @IBOutlet weak var eventName: UILabel!
    
    @IBOutlet weak var eventHost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = 15
        mainView.clipsToBounds = true

        
        applyElevatedShadow(to: mainView)
    }
    
    func addCellDatawithEventData(eventModel: EventModel) {
        eventDate.text = eventModel.eventDate
        eventName.text = eventModel.eventName
        eventHost.text = eventModel.organizerName
        
        eventImage.setImage(with: eventModel.imageUrl)
    }
    
    func applyElevatedShadow(to view: UIView, cornerRadius: CGFloat = 15, shadowRadius: CGFloat = 10, shadowOpacity: Float = 0.2, shadowColor: UIColor = .black, shadowOffset: CGSize = CGSize(width: 0, height: 4)) {
        // Corner radius
        view.layer.cornerRadius = cornerRadius
        
        // Shadow
        view.layer.masksToBounds = false
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOffset = shadowOffset
    }

}
