//
//  CustomView.swift
//  BirthdayReminder
//
//  Created by Sabina Grinenko on 17.07.2023.
//

import UIKit

class CustomView: UIView {
    let nameLabel = UILabel()
    let photo = UIImageView()
    let daysLeftLabel = UILabel()
    let descriptionLabel = UILabel ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        //setup photo
        photo.contentMode = .scaleAspectFit
        photo.clipsToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        addSubview(photo)
        
        //setup nameLabel
        nameLabel.textAlignment = .right
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        //setup daysLeftLabel
        daysLeftLabel.textAlignment = .left
        daysLeftLabel.font = UIFont.systemFont(ofSize: 17)
        daysLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(daysLeftLabel)
        
        //setup descripyionLabel
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 17)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            photo.leadingAnchor.constraint(equalTo: leadingAnchor),
            photo.topAnchor.constraint(equalTo: topAnchor),
            photo.widthAnchor.constraint(equalToConstant: 55),
            photo.heightAnchor.constraint(equalToConstant: 55),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: photo.leadingAnchor, constant: 55),
               
            daysLeftLabel.topAnchor.constraint(equalTo: topAnchor),
            daysLeftLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: photo.leadingAnchor, constant: 55),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(with image: UIImage?, name: String, description: String, daysLeft: String) {
        
            if let customPhoto = image {
                photo.image = CustomView.cropImageAndMakeCircular(customPhoto, with: CGSize(width: 55, height: 55))
            } else {
                photo.image = UIImage.init(systemName: "person.circle.fill")
            }
            nameLabel.text = name
            descriptionLabel.text = description
            daysLeftLabel.text = daysLeft
        }
    
    
    static func cropImageAndMakeCircular(_ image: UIImage, with size: CGSize) -> UIImage? {
     
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
    
    
}
