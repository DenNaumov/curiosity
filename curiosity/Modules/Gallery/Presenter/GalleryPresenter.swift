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
            interactor?.downloadNextPageImages()
        }
    }

    func openImage(_ url: URL) {
        router?.presentImage(withURL: url)
    }

    func readyToShow() {
        interactor?.downloadFirstPageImages()
    }
}

extension GalleryPresenter: GalleryInteractorToPresenterProtocol {

    func didFinishDownloadUpdate(_ localURLs: [URL]) {
        isUpdateDownloadInProgress = false
        viewController?.hideUpdateIndicator()
        viewController?.addToGallery(localURLs)
    }

    func didFinishDownloadInitialImages(_ localURLs: [URL]) {
        viewController?.initiateGallery(localURLs)
    }

    func didLoadSavedImages(_ localURLs: [URL]) {
        viewController?.initiateGalleryOffline(localURLs)
    }
    
    func reportError(_ text: String) {
        viewController?.showErrorMessage(text)
    }
}
