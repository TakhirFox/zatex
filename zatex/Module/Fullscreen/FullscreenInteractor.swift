//
//  FullscreenFullscreenInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 05/05/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol FullscreenInteractorProtocol {
    
}

class FullscreenInteractor: BaseInteractor, FullscreenInteractorProtocol {
    weak var presenter: FullscreenPresenterProtocol?

}