

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        let singinVC: SigninVC = SigninVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(singinVC, animated: true)
    }
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let registerVC: RegisterVC = RegisterVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}

