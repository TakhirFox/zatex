//
//  NewsNewsPresenter.swift
//  zatex
//
//  Created by winzero on 29/11/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

protocol NewsPresenterProtocol: AnyObject {

    func setNewsContent()
}

class NewsPresenter: BasePresenter {
    
    weak var view: NewsViewControllerProtocol?
    var interactor: NewsInteractorProtocol?
    var router: NewsRouterProtocol?
    var newsEntity: BannerResult?
}

extension NewsPresenter: NewsPresenterProtocol {
    
    func setNewsContent() {
        if let newsEntity = newsEntity {
            view?.showNewsContent(data: newsEntity)
        }
    }
}
