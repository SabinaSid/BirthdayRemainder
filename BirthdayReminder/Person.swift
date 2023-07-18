//
//  Person.swift
//  BirthdayReminder
//
//  Created by Sabina Grinenko on 17.07.2023.
//

import UIKit

enum Sex: String, CaseIterable {
    case male
    case female
}

class Person {
    var name: String
    var dateOfBirthday: Date
    var age: Int
    var sex: Sex
    var istagram: String
    var photo : UIImage?
    
    init(name: String, dateOfBirthday: Date, age: Int, sex: Sex, istagram: String) {
        self.name = name
        self.dateOfBirthday = dateOfBirthday
        self.age = age
        self.sex = sex
        self.istagram = istagram
    }
    
    convenience init(name: String, dateOfBirthday: Date, age: Int, sex: Sex, istagram: String, photo: UIImage?) {
         self.init(name: name, dateOfBirthday: dateOfBirthday, age: age, sex: sex, istagram: istagram)
         self.photo = photo
    }
    
    var message: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE, MMM d"
        
       
        let dayOfBirth = dateFormatter.string(from: dateOfBirthday)
        
        let pronoun = sex == Sex.male ? "his": "her"
        
        let suffixs = ["th", "st", "nd", "rd"]
        let lastDigit = (age + 1) % 10
        let suffix = (1...3).contains(lastDigit) ? suffixs[lastDigit] : suffixs[0]
        
        return "\(dayOfBirth), will be \(pronoun) \(age + 1)\(suffix) birthday"
    }
    
    var daysBeforeBirthday: String {
        var days = (Date.now.distance(to: birthdayThisYear)/60/60/24).rounded() + 1
        //if you've already had a birthday this year, get next year's
        if days < 0 {
            days = (Date.now.distance(to: birthdayNextYear)/60/60/24).rounded() + 1
        }
        
        var str = String()
        switch days {
        case 0: str = "Today"
        case 1: str = "\(days.formatted()) day left"
        default: str = "\(days.formatted()) days left"
        }
        
        return str
    }
    
    var birthdayThisYear: Date {
       
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd"
        let dayOfBirth = dateFormatter.string(from: dateOfBirthday)
        
        dateFormatter.dateFormat = "yyyy"
        let currentYear = dateFormatter.string(from: Date.now)
        
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date =  dateFormatter.date(from: "\(dayOfBirth)/\(currentYear)") ?? Date.now
        
        return date
    }
    
    var birthdayNextYear: Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd"
        let dayOfBirth = dateFormatter.string(from: dateOfBirthday)
        
        dateFormatter.dateFormat = "yyyy"
        let nextYear = dateFormatter.string(from: Date.init(timeIntervalSinceNow: 365*24*60*60))
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date =  dateFormatter.date(from: "\(dayOfBirth)/\(nextYear)") ?? Date.now
        
        return date
    }
}

