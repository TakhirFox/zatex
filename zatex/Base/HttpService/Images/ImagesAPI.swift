//
//  ImagesAPI.swift
//  zatex
//
//  Created by Zakirov Tahir on 08.04.2023.
//

import UIKit

typealias MediaClosure = (MediaResult) -> (Void)

protocol ImagesAPI {
    
    func loadImage(
        image: UIImage,
        completion: @escaping MediaClosure
    ) -> (Void)
}
