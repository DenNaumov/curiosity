//
//  GalleryPresenter.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import Foundation

class GalleryPresenter: GalleryPresenterAssemblyProtocol {

    weak var viewController: GalleryPresenterToViewProtocol?
    var interactor: GalleryPresenterToInteractorProtocol?
    var router: GalleryPresenterToRouterProtocol?

}

extension GalleryPresenter: GalleryViewToPresenterProtocol {
    func openImage(_ url: URL) {
        let viewController = self.viewController as! GalleryViewController
        if let navigationController = viewController.navigationController {
            router?.gotoImage(imageURL: url, navigation: navigationController)
        }
    }
    
    func readyToShow() {
        interactor?.loadImages()
    }
}

extension GalleryPresenter: GalleryInteractorToPresenterProtocol {
    func setURLs(_ urls: [URL]) {
        viewController?.addImages(urls)
    }
}
