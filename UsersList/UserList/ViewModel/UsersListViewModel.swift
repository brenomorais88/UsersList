//
//  UserListViewModel.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import Foundation

class UsersListViewModel: ViewModel {
    let delegate: UsersListCoordinatorProtocol
    
    init(delegate: UsersListCoordinatorProtocol) {
        self.delegate = delegate
        super.init()
    }
}
