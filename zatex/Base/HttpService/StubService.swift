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
    func fetchProducts(completion: ([ProductResult]) -> (Void)) {
        fatalError("Нет имплементации")
    }
    
    func fetchCategories(completion: ([CategoryResult]) -> (Void)) {
        fatalError("Нет имплементации")
    }
    
    
}
