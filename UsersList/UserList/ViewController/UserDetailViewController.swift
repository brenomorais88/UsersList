//
//  UserDetailViewController.swift
//  UsersList
//
//  Created by Breno Morais on 24/07/23.
//

import UIKit
import SnapKit

class UserDetailViewController: UIViewController {
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
    
    private let user: UsersList
    
    init(user: UsersList) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCodeSetup()
        loadUserDetails()
    }
    
    private func loadUserDetails() {
        self.userName.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
        self.userEmail.text = user.email
        self.userImg.imageFromURL(urlString: user.avatar ?? "")
    }
}

extension UserDetailViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.view.addSubview(userImg)
        self.view.addSubview(userName)
        self.view.addSubview(userEmail)
    }
    
    func viewCodeConstraintSetup() {
        userImg.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(150)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(40)
        }
        
        userName.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(userImg.snp.bottom).inset(-16)
        }
        
        userEmail.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(userName.snp.bottom).inset(-16)
        }
    }
    
    func viewCodeAdditioalSetup() {
        self.view.backgroundColor = UIColor.white
    }
}
