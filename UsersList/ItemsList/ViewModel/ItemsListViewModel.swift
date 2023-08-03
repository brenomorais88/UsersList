//
//  ItemsListViewModel.swift
//  UsersList
//
//  Created by Breno Morais on 03/08/23.
//

import Foundation

enum ItemsListViewState {
    case Loading
    case Data([Item])
    case Empty
}

class ItemsListViewModel: ViewModel {
    let delegate: ItemsListCoordinatorProtocol
    
    init(delegate: ItemsListCoordinatorProtocol) {
        self.delegate = delegate
        super.init()
    }
    
    var viewState: Observable<ItemsListViewState> = Observable(.Loading)
    
    private var itens: [Item] = []
    
    private var cache = ItemsListData()
    
    func loadData() {
        let itens = cache.getItems()
        self.itens = itens
        
        if itens.count > 0 {
            self.viewState.value = .Data(itens)
        } else {
            self.viewState.value = .Empty
        }
    }
    
    func getCurrentDataWith(text: String) -> [Item] {
        let filtered = self.itens.filter { $0.name.contains(text) }
        return filtered
    }
    
    func createNewItem(name: String) {
        let item = Item(name: name)
        cache.saveItem(item: item)
        self.loadData()
    }
}
