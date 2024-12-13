//
//  SlideView.swift
//  Levent
//
//  Created by Yusuf M on 6/12/2024.
//

import UIKit

class SlideView: UIView {

    @IBOutlet weak var slideImageView: UIImageView!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        slideImageView.layer.cornerRadius = 10
    }
    

}
