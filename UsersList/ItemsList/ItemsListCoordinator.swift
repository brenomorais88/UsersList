//
//  ItemsListCoordinator.swift
//  UsersList
//
//  Created by Breno Morais on 03/08/23.
//

import Foundation

protocol ItemsListCoordinatorProtocol {
    
}

class ItemsListCoordinator: Coordinator {
    
    override func didInit() {
        let viewModel = ItemsListViewModel(delegate: self)
        self.viewController = ItemsListViewController(viewModel: viewModel)
    }
}

extension ItemsListCoordinator: ItemsListCoordinatorProtocol {
    
}
