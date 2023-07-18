//
//  DataSourse.swift
//  BirthdayReminder
//
//  Created by Sabina Grinenko on 13.07.2023.
//

import UIKit

func dateFromString(_ date: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    
    return dateFormatter.date(from: date)
}

class DataSource: NSObject {
    
    var persons: [Person] = [
        Person(name: "Sabinka", dateOfBirthday: dateFromString("11/16/1999") ?? Date(), age: 22, sex: .female, istagram: "@sabinka"),
        Person(name: "Some woman", dateOfBirthday: dateFromString("07/18/1999") ?? Date(), age: 20, sex: .female, istagram: "@woman", photo: UIImage(named: "HerPhoto")),
        Person(name: "Some man", dateOfBirthday: dateFromString("01/15/1995") ?? Date(), age: 26, sex: .male, istagram: "@man", photo: UIImage(named: "HisPhoto"))
    ]
}
