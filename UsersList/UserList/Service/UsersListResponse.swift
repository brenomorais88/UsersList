//
//  UsersListResponse.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import Foundation

struct UsersListResponse: Decodable {
    let page: Int?
    let perPage: Int?
    let total: Int?
    let totalPages: Int?
    let users: [UsersList]?
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case perPage = "per_page"
        case total = "total"
        case totalPages = "total_pages"
        case users = "data"
    }
}

struct UsersList: Decodable {
    let id: Int?
    let email: String?
    let firstName: String?
    let lastName: String?
    let avatar: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "avatar"
    }
}
