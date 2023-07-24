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
        self.viewModel?.loadData()
        self.title = Strings.kUsersViewTitle.rawValue
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
                case .Error(let msg):
                    self?.setupErrorView(error: msg)
                case .Data(let users):
                    self?.setupDataView(users: users)
                }
            }
        })
    }
    
    private func setupLoadingView() {
        self.currentView = LoadingView()
        self.view = self.currentView
    }
    
    private func setupErrorView(error: String) {
        let errorView = ErrorView(error: error)
        errorView.delegate = self
        self.currentView = errorView
        self.view = self.currentView
    }
    
    private func setupDataView(users: [UsersList]) {
        let view = UserListView(users: users)
        view.delegate = self
        self.currentView = view
        self.view = self.currentView
    }
    
    private func setupEmptyView() {
        let alert = UIAlertController(title: Strings.kAlert.rawValue,
                                      message: Strings.kNoResultsMessage.rawValue,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Strings.kOk.rawValue, style: .default, handler: { action in
            alert.dismiss(animated: true)
            self.viewModel?.pageLoadedWithoutResults()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UsersListViewController: ErrorViewProtocol {
    func tryAgain() {
        self.viewModel?.loadUsersList()
    }
}

extension UsersListViewController: UserListViewProtocol {
    func showUserInfo(user: UsersList) {
        let vc = UserDetailViewController(user: user)
        self.present(vc, animated: true)
    }
    
    func loadMoreUsers() {
        self.viewModel?.loadNextPage()
    }
    
    func reloadData() {
        self.viewModel?.reloadData()
    }
}

