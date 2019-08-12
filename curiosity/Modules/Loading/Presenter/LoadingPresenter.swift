//
//  LoadingPresenter.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

class LoadingPresenter: LoadingPresenterAssemblyProtocol {

    weak var viewController: LoadingPresenterToViewProtocol?
    var interactor: LoadingPresenterToInteractorProtocol?
    var router: LoadingPresenterToRouterProtocol?

}

extension LoadingPresenter: LoadingViewToPresenterProtocol {
    func readyToShow() {
        interactor?.downloadImages()
    }
}

extension LoadingPresenter: LoadingInteractorToPresenterProtocol {

    func reportError(_ errorMessage: String) {
        viewController?.showError(errorMessage)
    }
    
    func imagesDownloadFinished() {
        let viewController = self.viewController as! LoadingViewController
        let navigationController = viewController.navigationController
        router?.gotoGallery(navigationController!)
    }
}
