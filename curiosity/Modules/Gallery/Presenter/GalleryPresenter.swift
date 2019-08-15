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
    var isUpdateDownloadInProgress = false
}

extension GalleryPresenter: GalleryViewToPresenterProtocol {

    func didLongPressOnItem(at indexPath: IndexPath) {
        viewController?.removeItemFromGallery(at: indexPath)
    }

    func didScrollToBottom() {
        if !isUpdateDownloadInProgress {
            isUpdateDownloadInProgress = true
            viewController?.showUpdateIndicator()
            interactor?.downloadNextPage()
        }
    }

    func openImage(_ url: URL) {
        let viewController = self.viewController as! GalleryViewController
        if let navigationController = viewController.navigationController {
            router?.gotoImage(imageURL: url, navigation: navigationController)
        }
    }

    func readyToShow() {
        interactor?.downloadFirstPage()
    }
}

extension GalleryPresenter: GalleryInteractorToPresenterProtocol {

    func didFinishDownloadUpdate(_ urls: [URL]) {
        isUpdateDownloadInProgress = false
        viewController?.hideUpdateIndicator()
        viewController?.addToGallery(urls)
    }

    func didFinishDownloadInitialImages(_ urls: [URL]) {
        viewController?.initiateGallery(urls)
    }
}
