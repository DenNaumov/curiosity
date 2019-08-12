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
}

protocol GalleryPresenterToViewProtocol: AnyObject {
    func addImages(_: [URL])
}

protocol GalleryPresenterToRouterProtocol: AnyObject {
    func gotoImage(imageURL: URL, navigation: UINavigationController)
}

protocol GalleryPresenterToInteractorProtocol: AnyObject {
    func loadImages()
}

protocol GalleryInteractorToPresenterProtocol: AnyObject {
    func setURLs(_: [URL])
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
