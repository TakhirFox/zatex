//
//  NewsService.swift
//  zatex
//
//  Created by Zakirov Tahir on 29.11.2023.
//

import Alamofire

class NewsService {
    private lazy var httpService = NewsHttpService()
    static let shared: NewsService = NewsService()
}

extension NewsService: NewsAPI {
    
    func fetchNewsList(
        completion: @escaping NewsListClosure
    ) {
        do {
            try NewsHttpRouter
                .getNewsList
                .request(usingHttpService: httpService)
                .responseDecodable(of: [BannerResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 783457893245 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 34563456435 Ошибка получения списка новостей")))
        }
    }
    
}
