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
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    let datePicker = UIDatePicker()
    let agePicker = UIPickerView()
    let sexPicker = UIPickerView()
    let dateFormatter = DateFormatter()
    
    var customPhoto: UIImage? = nil
    
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
        let person =  addPerson()
        
        //go to the previous scene
        if let person = person {
            if customPhoto != nil {
                person.photo = photoImageView.image
            }
            navigationController?.popViewController(animated: true)
            if let viewController = navigationController?.topViewController as? BirthdaysViewController {
                viewController.dataSourse.persons.append(person)
            }
        }
    }
    
    @objc func dateChanged() {
        bithdayTextField.text = dateFormatter.string(from: datePicker.date)
    }

    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    @IBAction func changePhotoButtonAct(_ sender: Any) {
        //upload the photo
        openGallery()
        
        //crop and save the photo
        /*
        if let photo = customPhoto {
            let cropCustomPhoto = CustomView.cropImageAndMakeCircular(photo, with: CGSize(width: 150, height: 150))
            photoImageView.image = cropCustomPhoto
        }
         */
    }
    
    func animateInvalidTextFiled(_ textField: UITextField)  {
        let originalColor = textField.backgroundColor
        let errorColor = UIColor.red
        let animationDuration = 0.9
        
        UIView.animate(withDuration: animationDuration, animations: {
            textField.backgroundColor = errorColor
        })
        
        UIView.animate(withDuration: animationDuration, animations: {
            textField.backgroundColor = originalColor
        })
        
    }
    
    func validateEmptyTextField(_ textField: UITextField) -> Bool {
        if textField.text == nil || textField.text!.isEmpty {
            return false
        }
        return true
    }
    
    func addPerson() -> Person?  {
        var name: String
        let bithday: Date
        let age: Int
        let sex: Sex
        let instagram: String
        
        if !validateEmptyTextField(nameTextField) {
            animateInvalidTextFiled(nameTextField)
            return nil
        }
        name = nameTextField.text!
        
        if !validateEmptyTextField(bithdayTextField) {
            animateInvalidTextFiled(bithdayTextField)
            return nil
        }
        
        if let day = dateFormatter.date(from: bithdayTextField.text!) {
            bithday = day
        } else {
            animateInvalidTextFiled(bithdayTextField)
            return nil
        }
      
        
        if !validateEmptyTextField(ageTextField) {
            animateInvalidTextFiled(ageTextField)
            return nil
        }
        
        if let number = Int(ageTextField.text!) {
            age = number
        } else {
            animateInvalidTextFiled(ageTextField)
            return nil
        }
      
        
        if !validateEmptyTextField(sexTextField) {
            animateInvalidTextFiled(sexTextField)
            return nil
        }
        
        if let gender = Sex(rawValue: sexTextField.text!) {
            sex = gender
        } else {
            animateInvalidTextFiled(sexTextField)
            return nil
        }
        
        if !validateEmptyTextField(intagramTextField){
            animateInvalidTextFiled(intagramTextField)
            return nil
        }
        instagram = intagramTextField.text!
        
  
        return Person(name: name, dateOfBirthday: bithday, age: age, sex: sex, istagram: instagram)
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

extension NewBirthdayViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func openGallery() {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                present(imagePicker, animated: true, completion: nil)
            }
        }

        // Обработка выбранного изображения
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                // Здесь можно использовать выбранное изображение
                // Например, вы можете установить его в UIImageView
                customPhoto = pickedImage
                
                if let photo = customPhoto {
                    let cropCustomPhoto = CustomView.cropImageAndMakeCircular(photo, with: CGSize(width: 150, height: 150))
                    photoImageView.image = cropCustomPhoto
                }
            }

            picker.dismiss(animated: true, completion: nil)
        }
    
    // Обработка отмены выбора изображения
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    
}
