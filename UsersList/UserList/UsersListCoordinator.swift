//
//  UserListCoordinator.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import Foundation

protocol UsersListCoordinatorProtocol {
    
}

class UsersListCoordinator: Coordinator {
    let service = UsersListService()
    override func didInit() {
        let viewModel = UsersListViewModel(delegate: self,
                                           service: self.service)
        self.viewController = UsersListViewController(viewModel: viewModel)
    }
}

extension UsersListCoordinator: UsersListCoordinatorProtocol {
    
}
