//
//  ImagesService.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.04.2023.
//

import Alamofire

class ImagesService {
    private lazy var httpService = ImagesHttpService()
    static let shared: ImagesService = ImagesService()
}

extension ImagesService: ImagesAPI {

    func loadImage(
        image: UIImage,
        completion: @escaping MediaClosure
    ) {
        do {
            try ImagesHttpRouter
                .loadImage(image: image)
                .request(usingHttpService: httpService)
                .responseDecodable(of: MediaResult.self) { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(.error(name: "Ошибка: 237707687 - \(error)")))
                    }
                }
        } catch {
            completion(.failure(.secondError(name: "Ошибка: 5570989677016 Ошибка загрузки медиа")))
        }
    }
}
