//
//  ListItemCell.swift
//  UsersList
//
//  Created by Breno Morais on 03/08/23.
//

import UIKit

class ListItemCell: UITableViewCell {
    static let cellID = "ListItemCell"
    
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.blue
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: "FilterCell")
        self.initialSetup()
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.viewCodeSetup()
    }
    
    func setup(name: String) {
        self.itemLabel.text = name
    }
}

extension ListItemCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(itemLabel)
    }
    
    func viewCodeConstraintSetup() {
        itemLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.top.right.left.equalToSuperview().inset(16)
        }
    }
}

