
import UIKit

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let dropdownData = ["Male", "Female", "Rather Not Say"]
    
    var userData: UserModel?
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var genderTextField: CustomTextField!
    @IBOutlet weak var birthdayTextField: CustomTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.dropShadow()
        getUserData()
        setupDropDowns()
        emailTextField.isUserInteractionEnabled = false
        
    }
    
    func getUserData(){
        LoaderView.shared.show()
        guard let userEmail = UserSessionManager.shared.getLoggedInUserEmail() else {
            print("No logged-in user email found.")
            LoaderView.shared.hide()
            return
        }
        let userFeatures = UserFeatures()
        userFeatures.fetchUserData(forEmail: userEmail) { [weak self] userData, error in
            LoaderView.shared.hide()
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let userData = userData {
                self?.userData = userData
                self?.userProfileImage.setImage(with: userData.profileImage)
                self?.nameTextField.text = userData.name
                self?.emailTextField.text = userData.email
                self?.passwordTextField.text = userData.password
                self?.genderTextField.text = userData.gender
                self?.birthdayTextField.text = userData.birthday
            }
        }
    }
    
    
    func setupDropDowns(){
        birthdayTextField.setDatePicker(mode: .date, placeholder: userData?.birthday ?? "Select Birthday") { selectedDate in
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            self.birthdayTextField.text = formatter.string(from: selectedDate)
        }
        // Configure Dropdown for Gender
        genderTextField.setDropdown(data: dropdownData, placeholder: "Select a gender") { selectedGender in
            self.genderTextField.text = selectedGender
        }
    }
    
    
    
    @IBAction func editProfileButtonPressed(_ sender: Any) {
        guard var userData = userData else { return }
        var hasChanges = false
        
        if nameTextField.text != userData.name {
            userData.name = nameTextField.text ?? userData.name
            hasChanges = true
        }
        
        if passwordTextField.text != userData.password {
            userData.password = passwordTextField.text ?? userData.password
            hasChanges = true
        }
        
        if genderTextField.text != userData.gender {
            userData.gender = genderTextField.text ?? userData.gender
            hasChanges = true
        }
        
        if birthdayTextField.text != userData.birthday {
            userData.birthday = birthdayTextField.text ?? userData.birthday
            hasChanges = true
        }
        
        if !hasChanges {
            showAlert(message: "No changes detected.")
            return
        }
        
        LoaderView.shared.show()
        let userFeatures = UserFeatures()
        userFeatures.updateUserData(forUser: userData) { [weak self] error in
            LoaderView.shared.hide()
            if let error = error {
                self?.showAlert(message: "Failed to update profile: \(error.localizedDescription)")
            } else {
                self?.showAlert(message: "Profile updated successfully."){
                    let storyboard = UIStoryboard(name: "UserScreens", bundle: nil)
                    if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeVCTabBar") as? UITabBarController {
                        self?.navigationController?.setViewControllers([homeViewController], animated: true)
                    }
                }
            }
            
        }
    }
        
        // Handle selected image from gallery
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                userProfileImage.image = selectedImage
            }
            dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
        
        
        @IBAction func userProfileImageButtonPressed(_ sender: Any) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }

