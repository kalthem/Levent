

import UIKit

class TicketsCell: UITableViewCell{
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var eventHost: UILabel!
    
    @IBOutlet weak var eventName: UILabel!
    
    @IBOutlet weak var eventDate: UILabel!
    
    override func awakeFromNib()  {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 15
        mainView.clipsToBounds = true
        
        applyElevatedShadow(to: mainView)
        
    }
    
    func addCellDatawithTicketData(ticketModel: TicketModel) {
        eventDate.text = ticketModel.eventDate
        eventName.text = ticketModel.eventName
        eventHost.text = ticketModel.eventOrganizer
        
        eventImage.setImage(with: ticketModel.eventImageUrl)
        
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
