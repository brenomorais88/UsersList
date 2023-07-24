//
//  UserListView.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import Foundation
import UIKit
import SnapKit

class UserListView: UIView {
    private let usersTable: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let users: [UsersList]
    
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
        self.usersTable.register(UsersCell.self,
                              forCellReuseIdentifier: UsersCell.cellID)
        self.usersTable.reloadData()
    }
}

extension UserListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: UsersCell.cellID,
                                                    for: indexPath) as? UsersCell {
            let user = self.users[indexPath.row]
            cell.setup(user: user)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.users[indexPath.row]
        print(user.lastName)
    }
}

