//
//  WelcomeViewController.swift
//  Levent
//
//  Created by Mahdi on 14/12/2024.
//
import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        print("Login button tapped")
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController {
            print("Navigating to LoginViewController")
            navigationController?.pushViewController(loginVC, animated: true)
        } else {
            print("Failed to instantiate LoginViewController")
        }
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        print("Register button tapped")
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController {
            print("Navigating to SignUpViewController")
            navigationController?.pushViewController(signUpVC, animated: true)
        } else {
            print("Failed to instantiate SignUpViewController")
        }
    }

}
