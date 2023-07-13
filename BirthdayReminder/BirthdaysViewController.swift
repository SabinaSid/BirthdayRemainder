//
//  BirthdaysViewController.swift
//  BirthdayReminder
//
//  Created by Sabina Grinenko on 12.07.2023.
//

import UIKit

class BirthdaysViewController: UIViewController {
    
    let dataSourse = DataSourse()
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        for person in dataSourse.persons {
            viewPerson(person)
        }
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        //Add new person
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(goToAddBirthday(add:))
        
        // Do any additional setup after loading the view.
    }
    
    func viewPerson(_ person: Person)  {
        
        let nameLabel = UILabel()
        let photo = UIImageView(image: person.photo)
        let daysLeftLabel = UILabel()
        let descriptionLabel = UILabel ()
        
        nameLabel.text = person.name
        daysLeftLabel.text = person.daysBeforeBirthday
        descriptionLabel.text = person.message
        
        nameLabel.center = view.center
        photo.center = view.center
        daysLeftLabel.center = view.center
        descriptionLabel.center = view.center
    
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(photo)
        stackView.addArrangedSubview(daysLeftLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
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
