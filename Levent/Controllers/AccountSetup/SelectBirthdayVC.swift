import UIKit
import FSCalendar
import FirebaseAuth
import FirebaseFirestore

class SelectBirthdayVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calendar: FSCalendar!
    var selectedGender: String?
    var selectedDOB: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        print("Selected Gender: \(selectedGender ?? "Not selected")")
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.isHidden = true
    }
    
    // Called when a date is selected from the calendar
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected Date: \(date)")
        selectedDOB = date
    }
    
    // Show or hide the calendar when the button is pressed
    @IBAction func calendarButtonPressed(_ sender: Any) {
        calendar.isHidden = !calendar.isHidden
    }
    
    // Called when the continue button is pressed
    @IBAction func continueButtonPressed(_ sender: Any) {
        // Check if the DOB is selected
        guard let dob = selectedDOB else {
            showAlert(message: "Please select your date of birth.")
            return
        }
        
        
        // Convert the selected date to DD/MM/YYYY format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDOB = dateFormatter.string(from: dob)
        
        let selectIntrestsVC: SelectIntrestsVC = SelectIntrestsVC.instantiate(appStoryboard: .accountSetup)
        selectIntrestsVC.selectedGender = selectedGender
        selectIntrestsVC.selectedDOB = formattedDOB
        navigationController?.pushViewController(selectIntrestsVC, animated: true)
        
        }
    
    // Function to show alert
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
