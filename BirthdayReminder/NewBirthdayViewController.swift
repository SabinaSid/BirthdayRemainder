//
//  NewBirthdayViewController.swift
//  BirthdayReminder
//
//  Created by Sabina Grinenko on 12.07.2023.
//

import UIKit

class NewBirthdayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up navigationBar
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(addBirthday(add:))
        // Do any additional setup after loading the view.
    }
    @objc func addBirthday(add: UIBarButtonItem)  {
        //add new bithday
        
        //go to the previous scene
        navigationController?.popViewController(animated: true)
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
