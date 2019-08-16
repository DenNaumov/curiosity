//
//  GalleryRouter.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit

class GalleryRouter {

    static func createModule() -> UIViewController {

        let viewController = GalleryViewController()

        let presenter = GalleryPresenter()
        let interactor = GalleryInteractor()
        let router = GalleryRouter()

        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return viewController
    }
}

extension GalleryRouter: GalleryPresenterToRouterProtocol {

    func gotoImage(imageURL: URL, navigation: UINavigationController) {
        let gallery = ImageRouter.createModule(imageURL: imageURL)
        navigation.pushViewController(gallery, animated: true)
    }
}
