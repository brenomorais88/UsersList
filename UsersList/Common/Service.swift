//
//  AppDelegate.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import Foundation
import Alamofire

class Service {
    let baseURL: String = "https://reqres.in/api/users?"
    let decoder = JSONDecoder()
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    init() {
        
    }
}
