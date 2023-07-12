//
//  BirthdaysViewController.swift
//  BirthdayReminder
//
//  Created by Sabina Grinenko on 12.07.2023.
//

import UIKit

class BirthdaysViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(goToAddBirthday(add:))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func goToAddBirthday(add: UIBarButtonItem)  {
        //go to the next scene
        
        if let navigationController = self.navigationController {
            if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewBirthdaySB") as? NewBirthdayViewController {
                
                //Set up navigationItem
                navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel")
                nextViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add")
                
                navigationController.pushViewController(nextViewController, animated: true)
            }
        }
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
