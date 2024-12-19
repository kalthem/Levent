//
//  SplashViewController.swift
//  Levent
//
//  Created by Mahdi on 16/12/2024.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.checkUserLoggedIn()
        }
    }
    
    private func setupUI() {
        imageLogo.image = UIImage(named: "Logo")
        labelTitle.text = "Levent"
        view.backgroundColor = .leventBeige
    }

    private func checkUserLoggedIn() {
        // Replace with your actual logic for checking login status
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")

        if isLoggedIn {
            self.navigateToHome()
        } else {
            self.navigateToWelcome()
        }
    }

    private func navigateToHome() {
        // Load Home storyboard
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        if let homeVC = storyboard.instantiateInitialViewController() {
            homeVC.modalTransitionStyle = .crossDissolve
            homeVC.modalPresentationStyle = .fullScreen
            self.present(homeVC, animated: true, completion: nil)
        }
    }

    private func navigateToWelcome() {
        // Load Welcome storyboard
        let storyboard = UIStoryboard(name: "WelcomeScreen", bundle: nil)
        if let welcomeVC = storyboard.instantiateInitialViewController() {
            welcomeVC.modalTransitionStyle = .crossDissolve
            welcomeVC.modalPresentationStyle = .fullScreen
            self.present(welcomeVC, animated: true, completion: nil)
        }
    }
}
