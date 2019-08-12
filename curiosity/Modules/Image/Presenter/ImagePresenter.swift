//
//  ImagePresenter.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

class ImagePresenter: ImagePresenterAssemblyProtocol {

    weak var viewController: ImagePresenterToViewProtocol?
    var interactor: ImagePresenterToInteractorProtocol?
    var router: ImagePresenterToRouterProtocol?

}

extension ImagePresenter: ImageViewToPresenterProtocol {

}

extension ImagePresenter: ImageInteractorToPresenterProtocol {

}
