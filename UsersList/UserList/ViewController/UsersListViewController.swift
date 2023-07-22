//
//  UserListViewController.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import UIKit

class UsersListViewController: UIViewController {
    let viewModel: UsersListViewModel?
    
    init(viewModel: UsersListViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
