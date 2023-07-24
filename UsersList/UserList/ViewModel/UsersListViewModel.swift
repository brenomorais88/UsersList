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
    case Error(String)
    case Data([UsersList])
}

class UsersListViewModel: ViewModel {
    let delegate: UsersListCoordinatorProtocol
    let service: UsersListServiceProtocol
    
    init(delegate: UsersListCoordinatorProtocol,
         service: UsersListServiceProtocol) {
        self.delegate = delegate
        self.service = service
        super.init()
    }
    
    var viewState: Observable<UserListViewState> = Observable(.Loading)
    private var users: [UsersList] = []
    
    func loadUsersList() {
        self.viewState.value = .Loading
        let params = UsersListRequest(page: 1, delay: 3)
        self.service.getUsersList(params: params) { success, response in
            if success {
                guard let list = response?.users else {
                    self.viewState.value = .Error(Strings.kErrorMessage.rawValue)
                    return
                }
                
                if list.count > 0 {
                    self.addUsers(users: list)
                } else {
                    self.viewState.value = .Empty
                }
                
            } else {
                self.viewState.value = .Error(Strings.kErrorMessage.rawValue)
            }
        }
    }
    
    func addUsers(users: [UsersList]) {
        self.users.append(contentsOf: users)
        self.viewState.value = .Data(self.users)
    }
}
