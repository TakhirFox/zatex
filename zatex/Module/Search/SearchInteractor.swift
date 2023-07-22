//
//  SearchSearchInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 25/10/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol SearchInteractorProtocol {
    func getSearchResult(searchText: String)
}

class SearchInteractor: BaseInteractor {
    weak var presenter: SearchPresenterProtocol?
    var service: SearchAPI!
    var searchText = ""
}

extension SearchInteractor: SearchInteractorProtocol {
    func getSearchResult(searchText: String) {
        self.service.fetchSearchResult(search: searchText) { result in
            switch result {
            case let .success(data):
                self.presenter?.setResultProducts(data: data)
                
            case let .failure(error):
                switch error {
                case let .error(name):
                    self.presenter?.setError(data: name)
                    
                case let .secondError(name):
                    self.presenter?.setError(data: name)
                }
            }
        }
    }
}
