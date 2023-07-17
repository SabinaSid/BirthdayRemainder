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
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        //Add new person
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(goToAddBirthday(add:))
        
        // Do any additional setup after loading the view.
    }
    
    func viewPerson(_ person: Person)  {
                
        let horizontalView = UIView()
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        //horizontalView.frame(forAlignmentRect: CGRect(x: 7, y: 100, width: 375, height: 75))
        
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        //nameLabel.frame(forAlignmentRect: CGRect(x: 55, y: 4, width: 185, height: 20))
        
        
        let photo = UIImageView(image: person.photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        //photo.frame(forAlignmentRect: CGRect(x: 0, y: 8, width: 55, height: 55))
        
        let daysLeftLabel = UILabel()
        daysLeftLabel.textAlignment = .left
        daysLeftLabel.frame(forAlignmentRect: CGRect(x: 250, y: 0, width: 125, height: 20))
        
        let descriptionLabel = UILabel ()
        descriptionLabel.frame(forAlignmentRect: CGRect(x: 55, y: 35, width: 320, height: 20))
        
        
        nameLabel.text = person.name
        daysLeftLabel.text = person.daysBeforeBirthday
        descriptionLabel.text = person.message
        
        horizontalView.addSubview(photo)
        horizontalView.addSubview(nameLabel)
        horizontalView.addSubview(descriptionLabel)
        horizontalView.addSubview(daysLeftLabel)
        
        stackView.addArrangedSubview(horizontalView)
        
        
        
        NSLayoutConstraint.activate([
                photo.leadingAnchor.constraint(equalTo: horizontalView.leadingAnchor),
                photo.topAnchor.constraint(equalTo: horizontalView.topAnchor),
                photo.bottomAnchor.constraint(equalTo: horizontalView.bottomAnchor),
                photo.widthAnchor.constraint(equalToConstant: 55),
                
                nameLabel.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 8),
                nameLabel.topAnchor.constraint(equalTo: horizontalView.topAnchor),
                
                descriptionLabel.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 8),
                descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
                
                daysLeftLabel.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 8),
                daysLeftLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
                daysLeftLabel.bottomAnchor.constraint(equalTo: horizontalView.bottomAnchor),
                
                // Ограничения для самого horizontalView
                
                horizontalView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                horizontalView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
                horizontalView.heightAnchor.constraint(equalToConstant: 75)
            ])
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
