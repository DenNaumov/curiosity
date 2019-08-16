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
    func openImage(_: URL)
    func didScrollToBottom()
    func didLongPressOnItem(at: IndexPath)
}

protocol GalleryPresenterToViewProtocol: AnyObject {
    func showUpdateIndicator()
    func hideUpdateIndicator()
    func initiateGallery(_: [URL])
    func addToGallery(_: [URL])
    func removeItemFromGallery(at: IndexPath)
    func initiateGalleryOffline(_: [URL])
    func showErrorMessage(_: String)
}

protocol GalleryPresenterToRouterProtocol: AnyObject {
    func gotoImage(imageURL: URL, navigation: UINavigationController)
}

protocol GalleryPresenterToInteractorProtocol: AnyObject {
    func loadSavedImages()
    func downloadFirstPageImages()
    func downloadNextPage()
}

protocol GalleryInteractorToPresenterProtocol: AnyObject {
    func didFinishDownloadInitialImages(_: [URL])
    func didFinishDownloadUpdate(_: [URL])
    func didLoadSavedImages(_: [URL])
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
