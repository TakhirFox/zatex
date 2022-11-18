//
//  SearchService.swift
//  zatex
//
//  Created by Zakirov Tahir on 30.10.2022.
//

import Alamofire

class SearchService {
    private lazy var httpService = SearchHttpService()
    static let shared: SearchService = SearchService()
}

extension SearchService: SearchAPI {
    func fetchSearchResult(search: String, completion: @escaping SearchClosure)  {
        do {
            try SearchHttpRouter
                .getSearchResult(search)
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ProductResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG 903941314: Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG 90767567456: Ошибка поиска")
        }
    }
    
    
}
