//
//  Defaults.swift
//  UsersList
//
//  Created by Breno Morais on 24/07/23.
//

import Foundation

enum DefaulsKeys: String {
    case lastCache = "lastCacheDate"
}

class Defaults: UserDefaults {
    static let shared = Defaults()
    
    //MARK: saveCacheInfo
    func saveCacheDate() {
        UserDefaults.standard.set(Date().toString(),
                                  forKey: DefaulsKeys.lastCache.rawValue)
    }
    
    func isValidCache() -> Bool {
        if minutesBetweenTwoDates(start: getLastCacheDate(), end: Date()) > 45 {
            return false
        }
        return true
    }
    
    func minutesBetweenTwoDates(start: Date, end: Date) -> Int {
        let diff = Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)
        let hours = diff / 3600
        let minutes = (diff - hours * 3600) / 60
        return minutes
    }
    
    func getLastCacheDate() -> Date {
        guard let startDate = UserDefaults.standard.string(forKey: DefaulsKeys.lastCache.rawValue) else {
            return Date()
        }
        return Date().getFromString(date: startDate)
    }
}
