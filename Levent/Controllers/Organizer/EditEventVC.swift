//
//  EditEventVC.swift
//  Levent
//
//   Created by Yusuf M on 9/12/2024.
//

import UIKit
class EditEventVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var isOrganizer : Bool?
    let dropdownData = ["Music", "Sports", "Art"]
    var eventDetails: EventModel?
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameTextField: CustomTextField!
    @IBOutlet weak var eventDescriptionTextField: CustomTextField!
    @IBOutlet weak var eventDateTextField: CustomTextField!
    @IBOutlet weak var eventTimeTextField: CustomTextField!
    @IBOutlet weak var eventCategoryTextField: CustomTextField!
    @IBOutlet weak var eventTicketPriceTextField: CustomTextField!
    @IBOutlet weak var eventLocationTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialData()
        setupDropDown()
        navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func editEventButtonPressed(_ sender: Any) {
        doEdit()
    }
    
    
    @IBAction func editImageButtonPressed(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
}




extension EditEventVC {
    
    func setupInitialData() {
        guard let eventDetails else { return }
        eventImage.setImage(with: eventDetails.imageUrl)
        eventNameTextField.text = eventDetails.eventName
        eventDescriptionTextField.text = eventDetails.eventDescription
        eventDateTextField.text = eventDetails.eventDate
        eventTimeTextField.text = eventDetails.eventTime
        eventCategoryTextField.text = eventDetails.eventCategory
        eventTicketPriceTextField.text = String(eventDetails.eventTicketPrice)
        eventLocationTextField.text = eventDetails.eventLocation
        
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
}

extension EditEventVC {
    func doEdit() {
        guard let eventDetails else { return }
        
        // Check if anything has changed
        let hasChanges =
            eventNameTextField.text != eventDetails.eventName ||
            eventDescriptionTextField.text != eventDetails.eventDescription ||
            eventDateTextField.text != eventDetails.eventDate ||
            eventTimeTextField.text != eventDetails.eventTime ||
            eventCategoryTextField.text != eventDetails.eventCategory ||
            eventTicketPriceTextField.text != String(eventDetails.eventTicketPrice) ||
            eventLocationTextField.text != eventDetails.eventLocation ||
            eventImage.image != UIImage(named: eventDetails.imageUrl)
        
        guard hasChanges else {
            showAlert(message: "No changes detected.")
            return
        }
        
        // Confirm edit action
        showConfirmationAlert(
            title: "Edit Event",
            message: "Are you sure you want to save the changes to this event?",
            confirmTitle: "Yes"
        ) { [weak self] in
            guard let self = self else { return }
            
            // Create updated event model
            let updatedEvent = EventModel(
                documentID: eventDetails.documentID,
                eventName: self.eventNameTextField.text ?? eventDetails.eventName,
                eventDescription: self.eventDescriptionTextField.text ?? eventDetails.eventDescription,
                eventDate: self.eventDateTextField.text ?? eventDetails.eventDate,
                eventTime: self.eventTimeTextField.text ?? eventDetails.eventTime,
                eventCategory: self.eventCategoryTextField.text ?? eventDetails.eventCategory,
                eventLocation: self.eventLocationTextField.text ?? eventDetails.eventLocation,
                eventTicketPrice: Double(self.eventTicketPriceTextField.text ?? "0") ?? eventDetails.eventTicketPrice,
                status: eventDetails.status,
                organizerEmail: eventDetails.organizerEmail,
                organizerName: eventDetails.organizerName,
                imageUrl: eventDetails.imageUrl,
                feedbackCount: eventDetails.feedbackCount,
                ticketsSold: eventDetails.ticketsSold,
                ratingsAndReviews: eventDetails.ratingsAndReviews
            )
            
            LoaderView.shared.show()
            OrganizerEventsFeatures().updateEvent(event: updatedEvent) { error in
                LoaderView.shared.hide()
                if let error = error {
                    self.showAlert(message: "Failed to update event: \(error.localizedDescription)")
                } else {
                    let eventEditSuccessVC: EventEditSuccessVC = EventEditSuccessVC.instantiate(appStoryboard: .organizer)
                    eventEditSuccessVC.isOrganizer = self.isOrganizer
                    self.navigationController?.pushViewController(eventEditSuccessVC, animated: true)
                }
            }
        }
    }
}
