//
//  ImagesHttpRouter.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.04.2023.
//

import Alamofire

enum ImagesHttpRouter {
    case loadImage(image: UIImage)
}

extension ImagesHttpRouter: HttpRouter {
    var baseUrlString: String {
        return "https://zakirovweb.online"
    }
    
    var path: String {
        switch self {
        case .loadImage:
            return "/wp-json/wp/v2/media"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .loadImage:
            return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .loadImage:
            let filename = "\(UUID().uuidString).jpeg"
            return [
                "Content-Type": "image/jpg",
                "Authorization": "Bearer \(token)",
                "Content-Disposition": "attachment; filename=\(filename)"
            ]
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .loadImage:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case let .loadImage(image):
            let imageData = image.pngData()
            return imageData
        }
    }
}
