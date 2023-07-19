//
//  NewBirthdayViewController.swift
//  BirthdayReminder
//
//  Created by Sabina Grinenko on 12.07.2023.
//

import UIKit

class NewBirthdayViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var bithdayTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var sexTextField: UITextField!
    
    @IBOutlet weak var intagramTextField: UITextField!
    
    let datePicker = UIDatePicker()
    let agePicker = UIPickerView()
    let sexPicker = UIPickerView()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - set up date formatter
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "en_US")
        
        //MARK: - set up pickers
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.maximumDate = .now
        datePicker.locale = Locale(identifier: "en_US")
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        agePicker.dataSource = self
        agePicker.delegate = self

        sexPicker.dataSource = self
        sexPicker.delegate = self
        
        //MARK: - set up text fields
        bithdayTextField.inputView = datePicker
        ageTextField.inputView = agePicker
        sexTextField.inputView = sexPicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton], animated: true)
        
        bithdayTextField.inputAccessoryView = toolBar
        ageTextField.inputAccessoryView = toolBar
        sexTextField.inputAccessoryView = toolBar
        
        bithdayTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        sexTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        ageTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        //MARK: -set up navigationBar
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(addBirthday(add:))
        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldEditingChanged(textFiled: UITextField){
        switch textFiled {
        case bithdayTextField:
            if let birthday = bithdayTextField.text {
                datePicker.date = dateFormatter.date(from: birthday) ?? Date.now
            }
        case ageTextField:
            if let age = ageTextField.text {
                let index = Int(age) ?? 0
                agePicker.selectRow(index, inComponent: 0, animated: true)
            }
        case sexTextField:
            if let sex = sexTextField.text {
                let rawValue = Sex(rawValue: sex)
                if let index = Sex.allCases.firstIndex(of: rawValue ?? Sex.female) {
                    sexPicker.selectRow(index, inComponent: 0, animated: true)
                }
            }
        default: return
        }
    }
    
    @objc func addBirthday(add: UIBarButtonItem)  {
        //add new bithday
        
        //go to the previous scene
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dateChanged() {
        bithdayTextField.text = dateFormatter.string(from: datePicker.date)
    }

    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    func addPerson()  {
        let name = nameTextField.text
        let bithday = bithdayTextField.text
        let age = ageTextField.text
        let sex = sexTextField.text
        let instagram = intagramTextField.text
    }

}


extension NewBirthdayViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
            case sexPicker: return Sex.allCases.count
            case agePicker: return 100
            default: return pickerView.numberOfComponents
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
            case sexPicker: return Sex.allCases[row].rawValue
            case agePicker: return "\(row)"
            default: return "\(row)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case sexPicker: sexTextField.text = Sex.allCases[row].rawValue
        case agePicker: ageTextField.text = "\(row)"
        default: return
        }
    }
    
}


