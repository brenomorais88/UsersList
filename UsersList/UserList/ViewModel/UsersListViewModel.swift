//
//  UserListViewModel.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import Foundation

enum UserListViewState {
    case Loading
    case Empty
    case Error
    case Data
}

class UsersListViewModel: ViewModel {
    let delegate: UsersListCoordinatorProtocol
    
    init(delegate: UsersListCoordinatorProtocol) {
        self.delegate = delegate
        super.init()
    }
    
    var viewState: Observable<UserListViewState> = Observable(.Loading)
}
