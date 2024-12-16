//
//  UserTableViewCell.swift
//  Levent
//
//  Created by Yusuf M on 13/12/2024.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let identifier = "UserTableViewCell"
    @IBOutlet weak var usernameLabel: UILabel!
    
    func configure(name: String) {
        usernameLabel.text = name
    }
    

}
