//
//  LoadingRouter.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit

class LoadingRouter {

    static func createModule() -> UIViewController {

        let viewController = LoadingViewController()
        
        
        let presenter = LoadingPresenter()
        let interactor = LoadingInteractor()
        let router = LoadingRouter()

        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return viewController
    }
}

extension LoadingRouter: LoadingPresenterToRouterProtocol {
    func gotoGallery(_ navigationController: UINavigationController) {
        let gallery = GalleryRouter.createModule()
        navigationController.pushViewController(gallery, animated: true)
    }
}
