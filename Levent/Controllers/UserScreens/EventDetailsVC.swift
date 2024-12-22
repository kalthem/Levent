

import UIKit

class EventDetailsVC: UIViewController {
    
    var eventData: EventModel?
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventHost: UILabel!
    @IBOutlet weak var eventTicketRate: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    
    override func viewDidLoad() {
        shadowView.dropShadow()
        setUpData()
    }

    @IBAction func buyNowButtonPressed(_ sender: Any) {
        let buyEventTicketsVC: BuyEventTicketsVC = BuyEventTicketsVC.instantiate(appStoryboard: .user)
        buyEventTicketsVC.eventData = eventData
        navigationController?.pushViewController(buyEventTicketsVC, animated: true)
    }
    
    func setUpData() {
        eventTitle.text = eventData?.eventName
        eventTime.text = "\(eventData?.eventDate ?? "") \(eventData?.eventTime ?? "")"
        eventName.text = eventData?.eventName
        eventHost.text = eventData?.organizerName
        eventTicketRate.text = String(eventData?.eventTicketPrice ?? 0.0)
        eventLocation.text = eventData?.eventLocation
        eventImage.setImage(with: eventData?.imageUrl)
        
    }
}
