

import UIKit

protocol AdminAllOrganizersXibTableViewDelegate: AnyObject {
    func deleteOrganizer(cell: AdminAllOrganizersXibTableView)
    func showOrganizerDetails(cell: AdminAllOrganizersXibTableView)
}

class AdminAllOrganizersXibTableView: UITableViewCell {
    weak var delegate: AdminAllOrganizersXibTableViewDelegate?
    
    @IBOutlet weak var organizerImage: UIImageView!
    @IBOutlet weak var organizerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        }
    
    func configure(organierModel: OrganizerModel){
        organizerName.text = organierModel.name
        organizerImage.setImage(with: organierModel.imageURL)
    }
    
    @IBAction func organizerDetailsButtonPressed(_ sender: Any) {
        delegate?.showOrganizerDetails(cell: self)
    }
    
    
    @IBAction func deleteOrganizerButtonPressed(_ sender: Any) {
        delegate?.deleteOrganizer(cell: self)
    }
}
