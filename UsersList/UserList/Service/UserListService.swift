//
//  UserListService.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import Foundation
import Alamofire

protocol UsersListServiceProtocol {
    func getUsersList(params: UsersListRequest, callback: @escaping (Bool, UsersListResponse?) -> ())
}

class UsersListService: Service, UsersListServiceProtocol {
    func getUsersList(params: UsersListRequest, callback: @escaping (Bool, UsersListResponse?) -> ()) {
        
        AF.request("\(self.baseURL)page=\(params.page)&delay=\(params.delay)",
                   method: .get,
                   encoding: URLEncoding.httpBody).response { response in

            switch response.result {
                case .success:
                do {
                    let parsedData = try self.decoder.decode(UsersListResponse.self,
                                                             from: response.data ?? Data())
                    callback(true, parsedData)
                    
                } catch {
                    callback(false, nil)
                }

                case .failure:
                    callback(false, nil)
            }
        }
    }
}
