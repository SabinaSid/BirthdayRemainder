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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - set up pickers
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.maximumDate = .now
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        //view.addSubview(datePicker)
        
        let agePickerController = AgePicker()
        agePicker.dataSource = agePickerController
        agePicker.delegate = agePickerController
        //view.addSubview(agePicker)
        
        let sexPickerController = SexPicker()
        sexPicker.dataSource = sexPickerController
        sexPicker.delegate = sexPickerController
        //view.addSubview(sexPicker)
        
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
        
        //MARK: -set up navigationBar
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(addBirthday(add:))
        // Do any additional setup after loading the view.
    }
    @objc func addBirthday(add: UIBarButtonItem)  {
        //add new bithday
        
        //go to the previous scene
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        bithdayTextField.text = dateFormatter.string(from: datePicker.date)
    }

 
    @objc func doneButtonTapped() {
        view.endEditing(true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


class AgePicker: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //super.ageTextField.text = "\(row)"
    }
    
}

class SexPicker: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Sex.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Sex.allCases[row].rawValue
    }
    
    
}


