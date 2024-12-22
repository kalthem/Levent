//
//  GenderSelectVC.swift
//  Levent
//
//  Created by Fatema Albaqali on 23/12/2024.
//

import UIKit

class GenderSelectVC: UIViewController{
    
    var selectedGender = "male"
    
    override func viewDidLoad() {
        setupUI()
    }
    
    
    @IBOutlet weak var maleCheckBox: UIImageView!
    
    @IBOutlet weak var femaleCHeckBox: UIImageView!
    
    
    @IBOutlet weak var maleView: UIView!
    
    @IBOutlet weak var femaleView: UIView!
    
    @IBOutlet weak var ratherNotSayView: UIView!
    
    
    @IBAction func maleButtonPressed(_ sender: Any) {
        maleCheckBox.image = UIImage(named: "filledCheckBoxImage") // Replace with your checked image
        femaleCHeckBox.image = UIImage(named: "emptyCheckBoxImage")  // Replace with your unchecked image
        ratherNotSayCheckBox.image = UIImage(named: "emptyCheckBoxImage")  // Replace with your unchecked image
        
        // Store the selected gender value
        selectedGender = "male"
    }
    
    @IBOutlet weak var ratherNotSayCheckBox: UIImageView!
    
    @IBAction func femaleButtonPressed(_ sender: Any) {
        femaleCHeckBox.image = UIImage(named: "filledCheckBoxImage")  // Replace with your checked image
        maleCheckBox.image = UIImage(named: "emptyCheckBoxImage")  // Replace with your unchecked image
        ratherNotSayCheckBox.image = UIImage(named: "emptyCheckBoxImage")  // Replace with your unchecked image
        
        // Store the selected gender value
        selectedGender = "female"
    }
    
    @IBAction func ratherNotSayButtonPressed(_ sender: Any) {
        ratherNotSayCheckBox.image = UIImage(named: "filledCheckBoxImage")  // Replace with your checked image
        maleCheckBox.image = UIImage(named: "emptyCheckBoxImage")  // Replace with your unchecked image
        femaleCHeckBox.image = UIImage(named: "emptyCheckBoxImage")  // Replace with your unchecked image
        
        // Store the selected gender value
        selectedGender = "ratherNotSay"
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        let selectBirthdayVC: SelectBirthdayVC = SelectBirthdayVC.instantiate(appStoryboard: .accountSetup)
        selectBirthdayVC.selectedGender = selectedGender
        self.navigationController?.pushViewController(selectBirthdayVC, animated: true)
    }
    
    
    func setupUI() {
        navigationItem.hidesBackButton = true

        // Apply the same styles to all views
        applyBorderStyling(to: maleView)
        applyBorderStyling(to: femaleView)
        applyBorderStyling(to: ratherNotSayView)
    }
    
    func applyBorderStyling(to view: UIView) {
        view.layer.cornerRadius = 10           // Set the border radius
        view.layer.borderWidth = 2             // Set the border width
        view.layer.borderColor = UIColor.appBlue.cgColor  // Set the border color
        view.clipsToBounds = true
    }
}
