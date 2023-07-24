//
//  UsersCache.swift
//  UsersList
//
//  Created by Breno Morais on 24/07/23.
//

import Foundation
import UIKit
import CoreData

class UsersCache {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveUsersCache(users: [UsersList]) {
        self.clearLastData()
        let context = appDelegate.persistentContainer.viewContext
        
        for item in users {
            guard let entity = NSEntityDescription.entity(forEntityName: "UserCache", in: context) else {
                return
            }
            
            let user = NSManagedObject(entity: entity, insertInto: context)
            user.setValue(item.id, forKey: "id")
            user.setValue(item.firstName, forKey: "name")
            user.setValue(item.lastName, forKey: "secondName")
            user.setValue(item.email, forKey: "email")
            user.setValue(item.avatar, forKey: "avatar")
            
            do {
                try context.save()
            } catch {
                print("Error saving")
            }
        }
        Defaults.shared.saveCacheDate()
    }
    
    private func clearLastData() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCache")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                context.delete(data)
            }
            try context.save()
        } catch {
            print("Failed")
        }
    }
    
    func getUsersFromCache() -> [UsersList] {
        var users: [UsersList] = []
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCache")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let id = data.value(forKey: "id") as? Int
                let email = data.value(forKey: "email") as? String
                let firstName = data.value(forKey: "name") as? String
                let lastName = data.value(forKey: "secondName") as? String
                let avatar = data.value(forKey: "avatar") as? String
                
                let user = UsersList(id: id,
                                     email: email,
                                     firstName: firstName,
                                     lastName: lastName,
                                     avatar: avatar)
                users.append(user)
            }
        } catch {
            print("Failed")
        }
    
        return users
    }
}
