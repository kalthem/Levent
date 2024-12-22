//
//  CreateNewEventVC.swift
//  Levent
//
//   Created by Yusuf M on 9/12/2024.
//

import UIKit
class CreateNewEventVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let dropdownData = ["Music", "Sports", "Art"]
    
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameTextField: CustomTextField!
    @IBOutlet weak var eventDescriptionTextField: CustomTextField!
    
    @IBOutlet weak var eventDateTextField: CustomTextField!
    @IBOutlet weak var eventTimeTextField: CustomTextField!
    @IBOutlet weak var eventCategoryTextField: CustomTextField!
    @IBOutlet weak var eventTicketPriceTextField: CustomTextField!
    @IBOutlet weak var eventLocationtextField: CustomTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropDown()
        
    }
    
    func setupDropDown() {
        // Configure Date Picker for Event Date
        eventDateTextField.setDatePicker(mode: .date, placeholder: "Select a date") { selectedDate in
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            self.eventDateTextField.text = formatter.string(from: selectedDate)
        }

        // Configure Time Picker for Event Time
        eventTimeTextField.setDatePicker(mode: .time, placeholder: "Select a time") { selectedTime in
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            self.eventTimeTextField.text = formatter.string(from: selectedTime)
        }

        // Configure Dropdown for Event Category
        eventCategoryTextField.setDropdown(data: dropdownData, placeholder: "Select a category") { selectedCategory in
            self.eventCategoryTextField.text = selectedCategory
        }
    }

    
    
    @IBAction func addImageButtonPressed(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Handle selected image from gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            eventImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createEventButtonPressed(_ sender: Any) {
        showConfirmationAlert(
            title: "Create Event",
            message: "Are you sure you want to create the event",
            confirmTitle: "Yes"
        ) { [weak self] in
            guard let self = self else { return }
            createTheEvent()
            let storyboard = UIStoryboard(name: "Organizer", bundle: nil)
            if let organizerHomeViewController = storyboard.instantiateViewController(withIdentifier: "OrganizerTabBarVC") as? UITabBarController {
                self.navigationController?.setViewControllers([organizerHomeViewController], animated: true) }
        }
    }
    
}

extension CreateNewEventVC{
    func createTheEvent(){
        // Validate all fields
        guard let name = eventNameTextField.text, !name.isEmpty else {
            showAlert(message: "Please enter the event name.")
            return
        }
        
        guard let description = eventDescriptionTextField.text, !description.isEmpty else {
            showAlert(message: "Please enter the event description.")
            return
        }
        
        guard let date = eventDateTextField.text, !date.isEmpty else {
            showAlert(message: "Please select the event date.")
            return
        }
        
        guard let time = eventTimeTextField.text, !time.isEmpty else {
            showAlert(message: "Please select the event time.")
            return
        }
        
        guard let category = eventCategoryTextField.text, !category.isEmpty else {
            showAlert(message: "Please select the event category.")
            return
        }
        
        guard let ticketPrice = eventTicketPriceTextField.text, !ticketPrice.isEmpty else {
            showAlert(message: "Please enter the ticket price.")
            return
        }
        
        guard let location = eventLocationtextField.text, !location.isEmpty else {
            showAlert(message: "Please enter the ticket price.")
            return
        }
        
        guard let image = eventImage.image else {
            showAlert(message: "Please add an event image.")
            return
        }
        
        // Get organizer details from the logged-in user
        guard let organizerEmail = UserSessionManager.shared.getLoggedInUserEmail(),
              let organizerName = UserSessionManager.shared.getLoggedInUserName() else {
            showAlert(message: "Unable to fetch organizer details. Please log in again.")
            return
        }

        
        // Placeholder values for fields to be filled later
        let emptyImageUrl = ""
        let emptyStatus = "ongoing" // Default status
        let feedbackCount = 0
        let ticketsSold = 0
        var ratingsAndReviews: [EventModel.RatingReview] = []

        let newReview = EventModel.RatingReview(reviewerName: "Ali", rating: 4, review: "Very nice")
        ratingsAndReviews.append(newReview)
        
        // Create the event object
        let event = EventModel(
            documentID: "",
            eventName: name.lowercased(),
            eventDescription: description,
            eventDate: date,
            eventTime: time,
            eventCategory: category,
            eventLocation: location,
            eventTicketPrice: Double(ticketPrice)!,
            status: emptyStatus,
            organizerEmail: organizerEmail,
            organizerName: organizerName,
            imageUrl: emptyImageUrl,
            feedbackCount: feedbackCount,
            ticketsSold: ticketsSold,
            ratingsAndReviews: ratingsAndReviews
        )
        
        LoaderView.shared.show()
        // Add the event using OrganizerEventFeatures
        let organizerEventFeatures = OrganizerEventsFeatures()
        organizerEventFeatures.createEvent(event: event) { error in
            LoaderView.shared.hide()
            if let error = error {
                self.showAlert(message: "Failed to create event: \(error.localizedDescription)")
            } else {
                self.showAlert(message: "Event added successfully!")
            }
        }
      
    }
}
