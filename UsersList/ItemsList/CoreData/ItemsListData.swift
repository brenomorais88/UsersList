//
//  ItemsListData.swift
//  UsersList
//
//  Created by Breno Morais on 03/08/23.
//

import Foundation
import UIKit
import CoreData

class ItemsListData {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveItem(item: Item) {
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "ItemCache", in: context) else {
            return
        }
        
        let itemCache = NSManagedObject(entity: entity, insertInto: context)
        itemCache.setValue(item.name, forKey: "name")
        
        do {
            try context.save()
        } catch {
            print("Error saving")
        }
        Defaults.shared.saveCacheDate()
    }
    
    func getItems() -> [Item] {
        var itens: [Item] = []
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemCache")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                let name = data.value(forKey: "name") as? String ?? ""
                
                let item = Item(name: name)
                itens.append(item)
            }
        } catch {
            print("Failed")
        }
    
        return itens
    }
}

