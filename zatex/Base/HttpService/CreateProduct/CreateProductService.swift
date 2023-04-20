//
//  CreateProductService.swift
//  zatex
//
//  Created by Zakirov Tahir on 06.04.2023.
//

import Alamofire

class CreateProductService {
    private lazy var httpService = CreateProductHttpService()
    static let shared: CreateProductService = CreateProductService()
}

extension CreateProductService: CreateProductAPI {
    
    func fetchCategories(completion: @escaping CreateProductCategoriesClosure) {
        do {
            try CreateProductHttpRouter
                .getCategories
                .request(usingHttpService: httpService)
                .responseDecodable(of: [CategoryResult].self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG 9263424: Ошибка  \(error)")
                    }
                }
            
        } catch {
            print("LOG 345634645: Ошибка категории на экране создания товара")
        }
    }
    
    func createProduct(
        product: ProductResponse,
        completion: @escaping CreateProductPostClosure
    ) {
        do {
            try CreateProductHttpRouter
                .createProduct(product: product)
                .request(usingHttpService: httpService)
                .responseDecodable(of: ProductResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(data)
                    case .failure(let error):
                        print("LOG 9928364: Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG 345632364645: Ошибка создание товара на экране создания товара")
        }
    }
}
