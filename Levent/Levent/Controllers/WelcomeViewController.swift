//
//  WelcomeViewController.swift
//  Levent
//
//  Created by Mahdi on 20/12/2024.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .leventBeige
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        if let loginVC = storyboard.instantiateInitialViewController() {
            navigationController?.pushViewController(loginVC, animated: true)
        }
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        if let registerVC = storyboard.instantiateInitialViewController() {
            navigationController?.pushViewController(registerVC, animated: true)
        }
    }
}
