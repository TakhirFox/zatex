//
//  NewsNewsInteractor.swift
//  zatex
//
//  Created by winzero on 29/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//


protocol NewsInteractorProtocol {
    
}

class NewsInteractor: BaseInteractor, NewsInteractorProtocol {
    weak var presenter: NewsPresenterProtocol?

}
