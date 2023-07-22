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
    override func didInit() {
        let viewModel = UsersListViewModel(delegate: self)
        self.viewController = UsersListViewController(viewModel: viewModel)
    }
}

extension UsersListCoordinator: UsersListCoordinatorProtocol {
    
}
