//
//  CardCollectionViewCell.swift
//  Levent
//
//  Created by Yusuf M on 9/12/2024.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CardCollectionViewCell"
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainImageView.layer.cornerRadius = 10
    }

}
