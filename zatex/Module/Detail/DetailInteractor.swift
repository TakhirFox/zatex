//
//  DetailDetailInteractor.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 03/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//


protocol DetailInteractorProtocol {
    
}

class DetailInteractor: BaseInteractor, DetailInteractorProtocol {
    weak var presenter: DetailPresenterProtocol?

}