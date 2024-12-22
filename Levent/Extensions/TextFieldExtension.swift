import UIKit

extension UITextField {

    // Function to configure Date Picker
    func setDatePicker(mode: UIDatePicker.Mode, placeholder: String, onChange: @escaping (Date) -> Void) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = mode
        datePicker.preferredDatePickerStyle = .wheels // Optional: Use .compact for inline style
        self.inputView = datePicker
        self.placeholder = placeholder
        
        // Add a toolbar with Done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(donePressed))
        doneButton.target = self
        toolbar.setItems([doneButton], animated: true)
        self.inputAccessoryView = toolbar

        // Date Picker Value Changed Closure
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)

        // Store closure in associated object
        objc_setAssociatedObject(self, &AssociatedKeys.onDateChange, onChange, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    // Function to configure Dropdown
    func setDropdown(data: [String], placeholder: String, onSelect: @escaping (String) -> Void) {
        self.placeholder = placeholder

        // Create PickerView
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self

        // Store dropdown data in associated object
        objc_setAssociatedObject(self, &AssociatedKeys.dropdownData, data, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.onDropdownSelect, onSelect, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        self.inputView = pickerView

        // Add a toolbar with Done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(donePressed))
        doneButton.target = self
        toolbar.setItems([doneButton], animated: true)
        self.inputAccessoryView = toolbar
    }

    @objc private func donePressed() {
        self.resignFirstResponder() // Close the picker or dropdown
    }

    @objc private func datePickerChanged(_ sender: UIDatePicker) {
        if let onChange = objc_getAssociatedObject(self, &AssociatedKeys.onDateChange) as? (Date) -> Void {
            onChange(sender.date)
        }
    }
}

// MARK: - Associated Keys for Closures and Data Storage
private struct AssociatedKeys {
    static var onDateChange = "onDateChange"
    static var dropdownData = "dropdownData"
    static var onDropdownSelect = "onDropdownSelect"
}

// MARK: - UIPickerView DataSource and Delegate for Dropdown
extension UITextField: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let data = objc_getAssociatedObject(self, &AssociatedKeys.dropdownData) as? [String] ?? []
        return data.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let data = objc_getAssociatedObject(self, &AssociatedKeys.dropdownData) as? [String] ?? []
        return data[row]
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let data = objc_getAssociatedObject(self, &AssociatedKeys.dropdownData) as? [String] ?? []
        if let onSelect = objc_getAssociatedObject(self, &AssociatedKeys.onDropdownSelect) as? (String) -> Void {
            onSelect(data[row])
        }
        self.text = data[row] // Set selected text in UITextField
    }
}
