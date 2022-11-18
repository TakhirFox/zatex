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
    func fetchProducts(completion: @escaping ([ProductResult]) -> (Void)) {
        do {
            try ProductHttpRouter
                .getProductsFromAllStore
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ProductResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG 213985: Ошибка  \(error)")
                    }
                }
            
        } catch {
            print("LOG 089123679: Ошибка категории")
        }
    }
    
    func fetchCategories(completion: @escaping ([CategoryResult]) -> (Void)) {
        do {
            try ProductHttpRouter
                .getCategories
                .request(usingHttpService: httpService)
                .responseDecodable(of: [CategoryResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG 9264: Ошибка  \(error)")
                    }
                }
            
        } catch {
            print("LOG 089123679: Ошибка категории")
        }
    }
    
    
}

extension ProductService {
    
}
