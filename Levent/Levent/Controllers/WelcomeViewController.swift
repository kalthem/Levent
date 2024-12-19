//
//  WelcomeViewController.swift
//  Levent
//
//  Created by Mahdi on 16/12/2024.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButtonStyles()
    }
    
    

    private func setupUI() {
        view.backgroundColor = .leventBeige
        imageLogo.image = UIImage(named: "Logo")
        labelTitle.text = "Levent"
        buttonLogin.setTitle("Login", for: .normal)
        buttonRegister.setTitle("Register", for: .normal)
    }

    private func setupButtonStyles() {
        let buttonBackgroundColor = UIColor.leventBlue
        let buttonTextColor = UIColor.leventWhite

        [buttonLogin, buttonRegister].forEach { button in
            button?.backgroundColor = buttonBackgroundColor
            button?.setTitleColor(buttonTextColor, for: .normal)
            button?.layer.cornerRadius = 8
            button?.layer.masksToBounds = true
        }
    }


    
    @IBAction func registerButtonTapped(_ sender: Any) {
        navigateToRegister()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        navigateToLogin()
    }
    
    private func navigateToLogin() {
        let storyboard = UIStoryboard(name: "LoginScreen", bundle: nil)
        if let loginVC = storyboard.instantiateInitialViewController() {
            navigationController?.pushViewController(loginVC, animated: true)
        }
    }

    private func navigateToRegister() {
        let storyboard = UIStoryboard(name: "RegisterScreen", bundle: nil)
        if let registerVC = storyboard.instantiateInitialViewController() {
            navigationController?.pushViewController(registerVC, animated: true)
        }
    }

}
