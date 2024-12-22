//
//  TermsAndConditionsVC.swift
//  Levent
//
//  Created by Fatema Albaqali on 23/12/2024.
//

import UIKit

class TermsAndConditionsVC: UIViewController {
    
    var selectedGender: String?
    var selectedDOB: String?
    var interests: [String] = []
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        guard let email = UserSessionManager.shared.getLoggedInUserEmail(),
              let gender = selectedGender,
              let dob = selectedDOB,
              !interests.isEmpty else {
            showAlert(message: "Please complete all fields before continuing.")
            return
        }

        LoaderView.shared.show()
        UserSessionManager.shared.setLoggedInUserInterests(userInterests: interests)
        UserFeatures().setupAccount(forEmail: email, gender: gender, birthday: dob, interests: interests) { [weak self] error in
            LoaderView.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(message: "Failed to set up account: \(error.localizedDescription)")
            } else {
                let storyboard = UIStoryboard(name: "UserScreens", bundle: nil)
                if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeVCTabBar") as? UITabBarController {
                    self.navigationController?.setViewControllers([homeViewController], animated: true)
                }
            }
        }
    }
}
