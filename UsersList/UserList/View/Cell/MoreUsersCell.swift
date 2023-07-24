//
//  MoreUsersCell.swift
//  UsersList
//
//  Created by Breno Morais on 24/07/23.
//

import UIKit

class MoreUsersCell: UITableViewCell {
    static let cellID = "MoreUsersCell"
    
    private let moreUsersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = Strings.kMoreUsers.rawValue
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
}

extension MoreUsersCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(moreUsersLabel)
    }
    
    func viewCodeConstraintSetup() {
        moreUsersLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.top.right.left.equalToSuperview().inset(16)
        }
    }
}
