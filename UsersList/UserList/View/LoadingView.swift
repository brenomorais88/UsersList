//
//  LoadingView.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import Foundation
import UIKit
import SnapKit

class LoadingView: UIView {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.kLoagindMsg.rawValue
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.startAnimating()
        return loading
    }()
    
    init() {
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

extension LoadingView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.addSubview(messageLabel)
        self.addSubview(loading)
    }
    
    func viewCodeConstraintSetup() {
        loading.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(loading.snp.bottom).inset(-16)
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
        }
    }
    
    func viewCodeAdditioalSetup() {
        self.loading.startAnimating()
    }
}
