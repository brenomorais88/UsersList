//
//  CompletionItemCell.swift
//  UsersList
//
//  Created by Breno Morais on 03/08/23.
//

import UIKit

class CompletionItemCell: UITableViewCell {
    static let cellID = "CompletionItemCell"
    
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: "CompletionItemCell")
        self.initialSetup()
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.backgroundColor = UIColor(rgb: 0xE1E1E1)
        self.selectionStyle = .none
        self.viewCodeSetup()
    }
    
    func setup(name: String) {
        self.itemLabel.text = name
    }
}

extension CompletionItemCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(itemLabel)
    }
    
    func viewCodeConstraintSetup() {
        itemLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
        }
    }
}

