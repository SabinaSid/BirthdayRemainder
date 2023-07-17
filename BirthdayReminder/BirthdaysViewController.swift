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
        stackView.spacing = 16
        
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
        
        testAvatar.image = cropImageAndMakeCircular(testAvatar.image!, with: CGSize(width: 55, height: 55))
        // Do any additional setup after loading the view.
    }
    
    func viewPerson(_ person: Person)  {
        let customView = CustomView()
        customView.configure(with: person.photo!, name: person.name, description: person.message, daysLeft: person.daysBeforeBirthday)
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
    
    @IBOutlet weak var testAvatar: UIImageView!
    
    func cropImageAndMakeCircular(_ image: UIImage, with size: CGSize) -> UIImage? {
     
        // Создаем круглую маску
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        let circlePath = UIBezierPath(ovalIn: CGRect(origin: .zero, size: size))
        context?.addPath(circlePath.cgPath)
        context?.closePath()
        context?.clip()

        // Налагаем обрезанное изображение на маску
        image.draw(in: CGRect(origin: .zero, size: size))

        // Получаем итоговое изображение
        let circularImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return circularImage
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
