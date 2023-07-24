//
//  UsersCell.swift
//  UsersList
//
//  Created by Breno Morais on 24/07/23.
//

import UIKit

class UsersCell: UITableViewCell {
    static let cellID = "UsersCell"
    
    private let userImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "avatar")
        return img
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let userEmail: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.darkGray
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.userEmail.text = ""
        self.userName.text = ""
        self.userImg.image = UIImage(named: "avatar")
    }
    
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
        
    }
    
    func setup(user: UsersList) {
        self.userName.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
        self.userEmail.text = user.email
        self.userImg.imageFromURL(urlString: user.avatar ?? "")
        self.viewCodeSetup()
    }
}

extension UsersCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(userImg)
        self.addSubview(userName)
        self.addSubview(userEmail)
    }
    
    func viewCodeConstraintSetup() {
        userImg.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(70)
            make.left.equalToSuperview().inset(16)
            make.bottom.top.equalToSuperview().inset(8)
        }
        
        userName.snp.makeConstraints { (make) -> Void in
            make.top.right.equalToSuperview().inset(16)
            make.left.equalTo(userImg.snp.right).inset(-16)
        }
        
        userEmail.snp.makeConstraints { (make) -> Void in
            make.right.equalToSuperview().inset(16)
            make.left.equalTo(userImg.snp.right).inset(-16)
            make.top.equalTo(userName.snp.bottom).inset(-8)
        }
    }
}
