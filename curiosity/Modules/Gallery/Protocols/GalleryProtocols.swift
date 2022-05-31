//
//  GalleryProtocols.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit
import Foundation

protocol GalleryViewToPresenterProtocol: AnyObject {
    func readyToShow()
    func openImage(_: ImageFile)
    func didScrollToBottom()
    func didLongPressOnItem(at: IndexPath)
}

protocol GalleryPresenterToViewProtocol: AnyObject {
    func showUpdateIndicator()
    func hideUpdateIndicator()
    func initiateGallery(_: [ImageFile])
    func addToGallery(_: [ImageFile])
    func removeItemFromGallery(at: IndexPath)
    func initiateGalleryOffline(_: [ImageFile])
    func showErrorMessage(_: String)
}

protocol GalleryPresenterToRouterProtocol: AnyObject {
    func presentImage(file: ImageFile)
}

protocol GalleryPresenterToInteractorProtocol: AnyObject {
    func loadSavedImages()
    func fetchFirstPageImageList()
    func fetchNextPageImageList()
}

protocol GalleryInteractorToPresenterProtocol: AnyObject {
    func didFinishDownloadInitialImages(_: [ImageFile])
    func didFinishDownloadUpdate(_: [ImageFile])
    func didLoadSavedImages(_: [ImageFile])
    func reportError(_: String)
}

// MARK: Gallery Assembly protocols

protocol GalleryViewAssemblyProtocol: AnyObject {
    var presenter: GalleryViewToPresenterProtocol? {get set}
}

protocol GalleryPresenterAssemblyProtocol: AnyObject {
    var viewController: GalleryPresenterToViewProtocol? {get set}
    var interactor: GalleryPresenterToInteractorProtocol? {get set}
    var router: GalleryPresenterToRouterProtocol? {get set}
}

protocol GalleryInteractorAssemblyProtocol: AnyObject {
    var presenter: GalleryInteractorToPresenterProtocol? {get set}
}
