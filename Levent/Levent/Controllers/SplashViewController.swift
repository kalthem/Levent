//
//  SplashViewController.swift
//  Levent
//
//  Created by Mahdi on 14/12/2024.
//

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set a timer to transition to the Welcome screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // 2-second delay
            self.goToWelcomeScreen()
        }
    }

    private func goToWelcomeScreen() {
        let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
        if let welcomeVC = storyboard.instantiateInitialViewController() as? WelcomeViewController {
            // Transition to Welcome screen
            self.navigationController?.setViewControllers([welcomeVC], animated: true)
        }
    }
}
