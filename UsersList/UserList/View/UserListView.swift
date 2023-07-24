//
//  UserListView.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import Foundation
import UIKit
import SnapKit

protocol UserListViewProtocol {
    func loadMoreUsers()
    func showUserInfo(user: UsersList)
}

class UserListView: UIView {
    private let usersTable: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let users: [UsersList]
    var delegate: UserListViewProtocol? = nil
    
    init(users: [UsersList]) {
        self.users = users
        super.init(frame: CGRect.zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.white
        self.viewCodeSetup()
    }
}

extension UserListView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(usersTable)
    }
    
    func viewCodeConstraintSetup() {
        usersTable.snp.makeConstraints { (make) -> Void in
            make.top.bottom.right.left.equalToSuperview()
        }
    }
    
    func viewCodeAdditioalSetup() {
        self.usersTable.delegate = self
        self.usersTable.dataSource = self
        self.usersTable.register(MoreUsersCell.self,
                              forCellReuseIdentifier: MoreUsersCell.cellID)
        self.usersTable.register(UsersCell.self,
                              forCellReuseIdentifier: UsersCell.cellID)
        self.usersTable.reloadData()
    }
}

extension UserListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.users.count {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MoreUsersCell.cellID,
                                                        for: indexPath) as? MoreUsersCell {
                return cell
            }
            
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: UsersCell.cellID,
                                                        for: indexPath) as? UsersCell {
                let user = self.users[indexPath.row]
                cell.setup(user: user)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == self.users.count {
            self.delegate?.loadMoreUsers()
        } else {
            let user = self.users[indexPath.row]
            self.delegate?.showUserInfo(user: user)
        }
    }
}

