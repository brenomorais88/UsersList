//
//  Date+extensions.swift
//  UsersList
//
//  Created by Breno Morais on 24/07/23.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.string(from: self)
        return date
    }
    
    func getFromString(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: date) {
            return date
        } else {
            return Date()
        }
    }
}

