//
//  ItemsListViewController.swift
//  UsersList
//
//  Created by Breno Morais on 03/08/23.
//

import UIKit

class ItemsListViewController: UIViewController {
    let viewModel: ItemsListViewModel?
    private var currentView: UIView?
    
    private let completionTable: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let tableHeaderLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.black
        view.text = "list itens"
        return view
    }()
    
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let newItemField: UITextField = {
        let view = UITextField()
        view.borderStyle = .line
        view.placeholder = "new item"
        return view
    }()
    
    private var errorView: UIView?
    private var itensView: UIView?
    private var loadingView: UIView?
    
    init(viewModel: ItemsListViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.viewCodeSetup()
        self.title = Strings.kItensViewTitle.rawValue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadListener()
        self.viewModel?.loadData()
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
                case .Data(let itens):
                    self?.setupDataView(itens: itens)
                }
            }
        })
    }
    
    private func setupLoadingView() {
        removeAllContentSubviews()
        let view = LoadingView()
        self.loadingView = view
        self.contentView.addSubview(view)
        
        view.snp.makeConstraints { (make) -> Void in
            make.bottom.right.left.top.equalToSuperview()
        }
    }
    
    private func setupDataView(itens: [Item]) {
        removeAllContentSubviews()
        let view = ItensListView(itens: itens)
        self.itensView = view
        self.contentView.addSubview(view)
        
        view.snp.makeConstraints { (make) -> Void in
            make.bottom.right.left.top.equalToSuperview()
        }
    }
    
    private func setupEmptyView() {
        removeAllContentSubviews()
        let errorView = ErrorView(error: "no items found")
        errorView.delegate = self
        self.errorView = errorView
        self.contentView.addSubview(errorView)
        
        errorView.snp.makeConstraints { (make) -> Void in
            make.bottom.right.left.top.equalToSuperview()
        }
    }
    
    private func removeAllContentSubviews() {
        self.errorView?.removeFromSuperview()
        self.itensView?.removeFromSuperview()
        self.loadingView?.removeFromSuperview()
    }
    
    private func createNewItem(name: String) {
        self.viewModel?.createNewItem(name: name)
    }
}

extension ItemsListViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        self.view.addSubview(newItemField)
        self.view.addSubview(contentView)
        self.view.addSubview(tableHeaderLabel)
        self.view.addSubview(completionTable)
    }
    
    func viewCodeConstraintSetup() {
        newItemField.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().inset(100)
            make.right.left.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        completionTable.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(newItemField.snp.bottom)
            make.right.left.equalToSuperview().inset(16)
            make.height.equalTo(0)
        }
        
        tableHeaderLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(newItemField.snp.bottom).inset(-16)
            make.right.left.equalToSuperview().inset(16)
        }
        
        contentView.snp.makeConstraints { (make) -> Void in
            make.bottom.right.left.equalToSuperview()
            make.top.equalTo(tableHeaderLabel.snp.bottom).inset(-16)
        }
    }
    
    func viewCodeAdditioalSetup() {
        newItemField.delegate = self
        
        self.completionTable.delegate = self
        self.completionTable.dataSource = self
        self.completionTable.register(CompletionItemCell.self,
                              forCellReuseIdentifier: CompletionItemCell.cellID)
        self.completionTable.reloadData()
    }
    
    func loadCompletion() {
        guard let completionItens = self.viewModel?.getCurrentDataWith(text: self.newItemField.text ?? "").count else {
            return
        }
        
        let tableHeight: CGFloat = CGFloat(40 * completionItens)
        self.completionTable.setHeight(tableHeight, animateTime: 0.5)
        self.completionTable.reloadData()
    }
}

extension ItemsListViewController: ErrorViewProtocol {
    func tryAgain() {
        self.viewModel?.loadData()
    }
}

extension ItemsListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, text != "" {
            createNewItem(name: text)
        }
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count ?? 2 > 1 {
            self.loadCompletion()
        }
        
        return true
    }
}

extension ItemsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.getCurrentDataWith(text: self.newItemField.text ?? "").count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.viewModel?.getCurrentDataWith(text: self.newItemField.text ?? "")[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CompletionItemCell.cellID,
                                                    for: indexPath) as? CompletionItemCell {
            cell.setup(name: item?.name ?? "")
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel?.getCurrentDataWith(text: self.newItemField.text ?? "")[indexPath.row]
        createNewItem(name: item?.name ?? "")
        newItemField.text = ""
        newItemField.resignFirstResponder()
        loadCompletion()
    }
}
