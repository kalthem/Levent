//
//  ViewController.swift
//  Levent
//
//  Created by k 3 on 04/12/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var mainHeaderView: UIView!
    
    lazy var slideView: SlideView = {
        let view = Bundle.main.loadNibNamed("SlideView", owner: nil)?.first as! SlideView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Homepage"
        
        mainHeaderView.addSubview(slideView)
        NSLayoutConstraint.activate([
            slideView.leadingAnchor.constraint(equalTo: mainHeaderView.leadingAnchor, constant: 10),
            slideView.trailingAnchor.constraint(equalTo: mainHeaderView.trailingAnchor, constant: -10),
            slideView.centerXAnchor.constraint(equalTo: mainHeaderView.centerXAnchor),
            slideView.heightAnchor.constraint(equalToConstant: 250)
            
        ])
        
        topHeaderView.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        topHeaderView.layer.shadowOffset = CGSize(width: 0, height: -2)
        topHeaderView.layer.shadowRadius = 4
        topHeaderView.layer.masksToBounds = false
//        statsView.layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
//        //statsView.layer.shadowOffset = CGSize(width: 2, height: 2)
//        statsView.layer.shadowRadius = 5
//        statsView.layer.cornerRadius = 10
        
        statsView.layer.cornerRadius = 10
        statsView.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        statsView.layer.borderWidth = 0.5
        
        
        statsView.layer.shadowColor = UIColor.black.cgColor
        statsView.layer.shadowOpacity = 0.2
        statsView.layer.shadowOffset = CGSize(width: 0, height: 0)
        statsView.layer.shadowRadius = 2
    }


}

