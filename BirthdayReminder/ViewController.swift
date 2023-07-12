//
//  ViewController.swift
//  BirthdayReminder
//
//  Created by Sabina Grinenko on 11.07.2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var hidePasswordButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func hidePasswordButtonAct(_ sender: Any) {
        
        passwordTextField.isSecureTextEntry.toggle()
        
        let imageName = passwordTextField.isSecureTextEntry ? "eye":  "eye.slash"
        
        hidePasswordButton.setImage(UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(scale: .medium)), for: .normal)
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func animateInvalidEmail()  {
        //emailTextField.text = String()
        let originalColor = emailTextField.backgroundColor
        let errorColor = UIColor.red
        let animationDuration = 0.9
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.emailTextField.backgroundColor = errorColor
        })
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.emailTextField.backgroundColor = originalColor
        })
        
    }
    
    @IBAction func sighInButtonAct(_ sender: Any) {
        
        //Check e-mail
        let email = emailTextField.text ?? ""
        
        if !validateEmail(email) {
           animateInvalidEmail()
            //return
        }
        
        //Go to the next scene
        if let navigationController = self.navigationController {
            if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "BirthdaysSB") as? BirthdaysViewController {
                
                //Set up navigationItem
                nextViewController.navigationItem.title = "Birthdays"
                nextViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
                
                navigationController.pushViewController(nextViewController, animated: true)
            }
        }
    }
    

}

