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

    func fetchProducts(page: Int, completion: @escaping ([ProductResult]) -> (Void)) {
        
        do {
            try ProductHttpRouter
                .getAllProducts(page)
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ProductResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                        guard !data.isEmpty else { return }
                    case .failure(let error):
                        print("LOG 213985: Ошибка  \(error)")
                    }
                }
            
        } catch {
            print("LOG 089123679: Ошибка продуктов")
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
    
    func fetchBanners(completion: @escaping BannersClosure) {
        do {
            try ProductHttpRouter
                .getBanners
                .request(usingHttpService: httpService)
                .responseDecodable(of: [BannerResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG 7802347: Ошибка  \(error)")
                    }
                }
            
        } catch {
            print("LOG 78902345678: Ошибка баннера")
        }
    }
    
    func fetchProductByCategory(id: String,
                                completion: @escaping ProdByCategoryClosure) {
        do {
            try ProductHttpRouter
                .getProductsByCategory(id)
                .request(usingHttpService: httpService)
                .responseDecodable(of: [ProductResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG 7325893578392: Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG 5763830496789: Ошибка фильтра категории")
        }
    }
    
}

extension ProductService {
    
}
