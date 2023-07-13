//
//  DataSourse.swift
//  BirthdayReminder
//
//  Created by Sabina Grinenko on 13.07.2023.
//

import UIKit

enum Sex {
    case male
    case female
}

struct Person {
    var name: String
    var dateOfBirthday: Date
    var age: Int
    var sex: Sex
    var istagram: String
    var photo = UIImage.init(systemName: "person.circle.fill")
    
    var message: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE, MMM d"
        
       
        let dayOfBirth = dateFormatter.string(from: dateOfBirthday)
        print(dateOfBirthday.description)
        print(dayOfBirth)
        
        let pronoun = sex == Sex.male ? "his": "her"
        
        let suffixs = ["th", "st", "nd", "rd"]
        let lastDigit = (age + 1) % 10
        let suffix = (1...3).contains(lastDigit) ? suffixs[lastDigit] : suffixs[0]
        
        print("\(dayOfBirth), will be \(pronoun) \(age + 1)\(suffix) birthday")
        
        return "\(dayOfBirth), will be \(pronoun) \(age + 1)\(suffix) birthday"
    }
    
    var daysBeforeBirthday: String {
        let days = Int(Date.now.distance(to: birthdayThisYear)/60/60/24) + 1
        let str = days > 1 ? "\(days) days left" : "\(days) day left"
        print(str)
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
}

func dateFromString(_ date: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    
    return dateFormatter.date(from: date)
}

class DataSourse: NSObject {
    
    var persons: [Person] = [
        Person(name: "Sabinka", dateOfBirthday: dateFromString("11/16/1999") ?? Date(), age: 22, sex: .female, istagram: "@sabinka"),
        Person(name: "Sabinka2", dateOfBirthday: dateFromString("07/14/1999") ?? Date(), age: 21, sex: .male, istagram: "@sabinka"),
        Person(name: "Sabinka2", dateOfBirthday: dateFromString("07/17/1999") ?? Date(), age: 20, sex: .male, istagram: "@sabinka")
    ]
}
