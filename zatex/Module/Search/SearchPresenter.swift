//
//  SearchSearchPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 25/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol SearchPresenterProtocol: AnyObject {
    func getSearchData(text: String)
    
    func goToDetail(id: Int)
    
    func setResultProducts(data: [ProductResult])
}

class SearchPresenter: BasePresenter {
    weak var view: SearchViewControllerProtocol?
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
}

extension SearchPresenter: SearchPresenterProtocol {
    // MARK: To Interactor
    func getSearchData(text: String) {
        interactor?.getSearchResult(searchText: text)
    }
    
    // MARK: To Router
    func goToDetail(id: Int) {
        router?.routeToDetail(id: id)
    }
    
    // MARK: To View
    func setResultProducts(data: [ProductResult]) {
        view?.setResultProducts(data: data)
    }
}
