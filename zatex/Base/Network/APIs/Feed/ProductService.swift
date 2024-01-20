//
//  ProductService.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Alamofire

class ProductService {
    private lazy var httpService = ProductHttpService()
    static let shared: ProductService = ProductService()
}

extension ProductService: ProductAPI {
    
    func fetchProducts(
        categoryId: Int?,
        page: Int,
        city: String,
        completion: @escaping ProductsClosure
    ) {
        do {
            try ProductHttpRouter
                .getAllProducts(
                    categoryId: categoryId,
                    page: page,
                    city: city
                )
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ProductResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                        guard !data.isEmpty else { return }
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 213985 - \(error)")))
                    }
                }
            
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 089123679 Ошибка продуктов")))
        }
    }
    
    func fetchCategories(completion: @escaping CategoriesClosure) {
        do {
            try ProductHttpRouter
                .getCategories
                .request(usingHttpService: httpService)
                .responseDecodable(of: [CategoryResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                        guard !data.isEmpty else { return }
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 9264 - \(error)")))
                    }
                }
            
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 089123679 Ошибка категории")))
        }
    } 
}

extension ProductService {
    
}
