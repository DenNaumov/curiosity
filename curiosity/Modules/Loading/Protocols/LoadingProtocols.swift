//
//  LoadingProtocols.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit

protocol LoadingViewToPresenterProtocol: AnyObject {
    func readyToShow()
}

protocol LoadingPresenterToViewProtocol: AnyObject {
    func showError(_: String)
}

protocol LoadingPresenterToRouterProtocol: AnyObject {
    func gotoGallery(_: UINavigationController)
}

protocol LoadingPresenterToInteractorProtocol: AnyObject {
    func downloadImages()
}

protocol LoadingInteractorToPresenterProtocol: AnyObject {
    func imagesDownloadFinished()
    func reportError(_: String)
}

// MARK: Loading Assembly protocols

protocol LoadingViewAssemblyProtocol: AnyObject {
    var presenter: LoadingViewToPresenterProtocol? {get set}
}

protocol LoadingPresenterAssemblyProtocol: AnyObject {
    var viewController: LoadingPresenterToViewProtocol? {get set}
    var interactor: LoadingPresenterToInteractorProtocol? {get set}
    var router: LoadingPresenterToRouterProtocol? {get set}
}

protocol LoadingInteractorAssemblyProtocol: AnyObject {
    var presenter: LoadingInteractorToPresenterProtocol? {get set}
}
