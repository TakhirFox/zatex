//
//  NewsNewsPresenter.swift
//  zatex
//
//  Created by winzero on 29/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol NewsPresenterProtocol: AnyObject {

}

class NewsPresenter: BasePresenter {
    weak var view: NewsViewControllerProtocol?
    var interactor: NewsInteractorProtocol?
    var router: NewsRouterProtocol?
    
}

extension NewsPresenter: NewsPresenterProtocol {
    
}
