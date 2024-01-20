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
    
    func fetchProducts(
        categoryId: Int?,
        page: Int,
        city: String,
        completion: @escaping ProductsClosure
    ) {
        fatalError("Нет имплементации")
    }
    
    func fetchCategories(completion: @escaping CategoriesClosure) {
        let category = [CategoryResult(id: 1, count: nil, name: "assasa", description: "", selected: true),
                        CategoryResult(id: 2, count: nil, name: "gsehgf", description: "", selected: false),
                        CategoryResult(id: 3, count: nil, name: "hdrth", description: "", selected: false),
                        CategoryResult(id: 4, count: nil, name: "vbnhjdrft", description: "", selected: false)]
        
        completion(.success(category))
    }
}
