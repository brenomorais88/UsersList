//
//  UserListViewController.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import UIKit

class UsersListViewController: UIViewController {
    let viewModel: UsersListViewModel?
    private var currentView: UIView?
    
    init(viewModel: UsersListViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadListener()
    }
    
    private func loadListener() {
        viewModel?.viewState.bind({ [weak self] viewState in
            guard let viewState = viewState else {
                return
            }
            
            DispatchQueue.main.async {
                switch viewState {
                case .Loading:
                    self?.setupLoadingView()
                case .Empty:
                    self?.setupEmptyView()
                case .Error:
                    self?.setupErrorView()
                case .Data:
                    self?.setupDataView()
                }
            }
        })
    }
    
    private func setupLoadingView() {
        self.currentView = LoadingView()
        self.view = self.currentView
    }
    
    private func setupErrorView() {
        
    }
    
    private func setupEmptyView() {
        
    }
    
    private func setupDataView() {
        
    }
}
