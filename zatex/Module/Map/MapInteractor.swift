//
//  MapMapInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 02/04/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol MapInteractorProtocol {
    
}

class MapInteractor: BaseInteractor {
    weak var presenter: MapPresenterProtocol?

}

extension MapInteractor: MapInteractorProtocol {
    
}
