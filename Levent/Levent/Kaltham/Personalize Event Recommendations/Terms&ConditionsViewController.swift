//
//  Terms&Conditions.swift
//  Levent
//
//  Created by k 3 on 10/12/2024.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {

    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var cbAgree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        resetCheckbox()
    }

    func setupTextView() {
        // Load your terms and conditions text
        let termsText = """
        Last Updated: 10/December/2024
        
        Welcome to Levent! By using our app, you agree to comply with and be bound by the following terms and conditions. Please read them carefully.
        
        1. Acceptance of Terms
        By accessing or using Levent, you agree to these Terms and Conditions and our Privacy Policy. If you do not agree, please do not use our app.
        
        2. Changes to Terms
        We reserve the right to modify these terms at any time. We will notify you of any changes by posting the new terms in the app. Your continued use of the app after changes are made constitutes your acceptance of the new terms.
        
        3. User Accounts
        You may need to create an account to access certain features.
        You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.
        You agree to notify us immediately of any unauthorized use of your account.
        
        4. User Conduct
        You agree not to use the app for any unlawful purpose, including but not limited to:
        Violating any applicable laws or regulations.
        Transmitting harmful or offensive content.
        Impersonating any person or entity.
        
        5. Content
        You are responsible for the content you post or share through the app.
        We do not endorse or guarantee the accuracy of any user-generated content.
        We reserve the right to remove any content that violates these terms or is deemed inappropriate.
        
        6. Intellectual Property
        All content, features, and functionality of the app, including text, graphics, logos, and software, are the exclusive property of Levent and are protected by applicable copyright, trademark, and other intellectual property laws.
        
        7. Third-Party Links
        Our app may contain links to third-party websites or services. We are not responsible for the content or practices of those websites. You access them at your own risk.
        
        8. Limitation of Liability
        To the fullest extent permitted by law, Levent shall not be liable for any direct, indirect, incidental, special, consequential, or punitive damages arising from your use of the app.
        
        9. Indemnification
        You agree to indemnify and hold harmless Levent, its affiliates, and their respective officers, directors, employees, and agents from any claims, losses, liabilities, damages, costs, or expenses arising out of your use of the app.
        """
        
        textView.text = termsText
        textView.isEditable = false // Prevent editing
    }
    
    
    @IBAction func cbAgreeTapped(_ sender: Any) {
        cbAgree.isSelected.toggle() // Toggle selection state

                // Check the selection state and update the image
                if cbAgree.isSelected == true{
                    cbAgree.setImage(UIImage(systemName: "checkmark.square"), for: .normal) // Set checkmark image
                    acceptButton.isEnabled = true // Enable accept button if applicable
                } else {
                    cbAgree.setImage(UIImage(systemName: "square"), for: .normal) // Set unchecked image
                    acceptButton.isEnabled = false // Disable accept button if applicable
                }
    }
    
    private func resetCheckbox() {
           cbAgree.isSelected = false // Reset selection state
           cbAgree.setImage(UIImage(systemName: "square"), for: .normal) // Set initial image
           acceptButton.isEnabled = false // Disable accept button initially
       }

    @IBAction func acceptTapped(_ sender: UIButton) {
        // Dismiss the Terms and Conditions view
        dismiss(animated: true, completion: nil)
    }
}
