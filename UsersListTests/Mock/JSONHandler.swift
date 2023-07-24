//
//  JSONHandler.swift
//  UsersListTests
//
//  Created by Breno Morais on 24/07/23.
//

import Foundation

class JSONHandler {
    
    func readJson <T: Codable> (type: T.Type, fileName: String) -> T? {
        if let path = Bundle(for: JSONHandler.self).path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let result = try JSONDecoder().decode(type.self, from: data)
                return result
                
            } catch let error {
                print(error)
            }
        }
        return nil
    }
}
