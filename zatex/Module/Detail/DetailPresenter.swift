//
//  DetailDetailPresenter.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 03/11/2022.
//  Copyright © 2022 zakirovweb. All rights reserved.
//

protocol DetailPresenterProtocol: AnyObject {

}

class DetailPresenter: BasePresenter {
    weak var view: DetailViewControllerProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    
}

extension DetailPresenter: DetailPresenterProtocol {
    
}
