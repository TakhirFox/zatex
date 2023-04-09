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
                        completion(data)
                    case .failure(let error):
                        print("LOG: 237707687 Ошибка  \(error)")
                    }
                }
        } catch {
            print("LOG: 5570989677016 Ошибка загрузки медиа")
        }
    }
}
