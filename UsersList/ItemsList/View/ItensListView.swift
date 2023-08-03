//
//  ItensListView.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import Foundation
import UIKit
import SnapKit

class ItensListView: UIView {
    private let itensTable: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let itens: [Item]
    
    init(itens: [Item]) {
        self.itens = itens
        super.init(frame: CGRect.zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.blue
        self.viewCodeSetup()
    }
}

extension ItensListView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(itensTable)
    }
    
    func viewCodeConstraintSetup() {
        itensTable.snp.makeConstraints { (make) -> Void in
            make.top.bottom.right.left.equalToSuperview()
        }
    }
    
    func viewCodeAdditioalSetup() {
        self.itensTable.delegate = self
        self.itensTable.dataSource = self
        self.itensTable.register(ListItemCell.self,
                              forCellReuseIdentifier: ListItemCell.cellID)
        self.itensTable.reloadData()
    }
}

extension ItensListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.itens[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListItemCell.cellID,
                                                    for: indexPath) as? ListItemCell {
            cell.setup(name: item.name)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

