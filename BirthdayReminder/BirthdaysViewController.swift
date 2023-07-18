//
//  BirthdaysViewController.swift
//  BirthdayReminder
//
//  Created by Sabina Grinenko on 12.07.2023.
//

import UIKit

class BirthdaysViewController: UIViewController {
    
    let dataSourse = DataSource()
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 32
        
        for person in dataSourse.persons {
            viewPerson(person)
        }
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        //Add new person
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(goToAddBirthday(add:))
    }
    
    func viewPerson(_ person: Person)  {
        let customView = CustomView()
        
        customView.configure(with: person.photo, name: person.name, description: person.message, daysLeft: person.daysBeforeBirthday)
        
        stackView.addArrangedSubview(customView)
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
    
}
