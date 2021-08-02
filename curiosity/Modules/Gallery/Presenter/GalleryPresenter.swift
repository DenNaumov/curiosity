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

    func openImage(_ url: ImageFile) {
        router?.presentImage(file: url)
    }

    func readyToShow() {
        interactor?.downloadFirstPageImages()
    }
}

extension GalleryPresenter: GalleryInteractorToPresenterProtocol {

    func didFinishDownloadUpdate(_ imageFiles: [ImageFile]) {
        isUpdateDownloadInProgress = false
        viewController?.hideUpdateIndicator()
        viewController?.addToGallery(imageFiles)
    }

    func didFinishDownloadInitialImages(_ imageFiles: [ImageFile]) {
        viewController?.initiateGallery(imageFiles)
    }

    func didLoadSavedImages(_ imageFiles: [ImageFile]) {
        viewController?.initiateGalleryOffline(imageFiles)
    }
    
    func reportError(_ text: String) {
        viewController?.showErrorMessage(text)
    }
}
