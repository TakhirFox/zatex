//
//  StubService.swift
//  zatex
//
//  Created by Zakirov Tahir on 22.10.2022.
//

import Foundation

class StubService {
    static let shared: StubService = StubService()
    private init() {}
}

extension StubService: ProductAPI {
    func fetchProducts(page: Int, completion: @escaping ProductsClosure) {
        fatalError("Нет имплементации")
    }
    
    func fetchBanners(completion: @escaping BannersClosure) {
        fatalError("Нет имплементации")
    }
    
    func fetchCategories(completion: @escaping CategoriesClosure) {
        let category = [CategoryResult(id: 1, count: nil, name: "assasa", selected: true),
                        CategoryResult(id: 2, count: nil, name: "gsehgf", selected: false),
                        CategoryResult(id: 3, count: nil, name: "hdrth", selected: false),
                        CategoryResult(id: 4, count: nil, name: "vbnhjdrft", selected: false)]
        
        completion(.success(category))
    }
    
    func fetchProductByCategory(id: String, completion: @escaping ProdByCategoryClosure) {
        fatalError("Нет имплементации")
    }
    
    
}
