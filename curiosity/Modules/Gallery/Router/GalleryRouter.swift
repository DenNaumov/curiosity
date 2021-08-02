//
//  GalleryRouter.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit

class GalleryRouter {

    private let rootController: UINavigationController
    static func createModule() -> UIViewController {

        let viewController = GalleryViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let presenter = GalleryPresenter()
        let interactor = GalleryInteractor()
        let router = GalleryRouter(rootController: navigationController)

        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return navigationController
    }
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
}

extension GalleryRouter: GalleryPresenterToRouterProtocol {

    func presentImage(file: ImageFile) {
        let imageModule = ImageRouter.createModule(with: file)
        rootController.pushViewController(imageModule, animated: true)
    }
}
