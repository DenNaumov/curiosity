//
//  ImageProtocols.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit

protocol ImageViewToPresenterProtocol: AnyObject {
    func readyToShow()
}

protocol ImagePresenterToViewProtocol: AnyObject {
    func showImage(from: ImageFile)
}

protocol ImagePresenterToRouterProtocol: AnyObject {
    // MARK: define protocol

}

protocol ImagePresenterToInteractorProtocol: AnyObject {
    // MARK: define protocol

}

protocol ImageInteractorToPresenterProtocol: AnyObject {
    // MARK: define protocol

}

// MARK: Image Assembly protocols

protocol ImageViewAssemblyProtocol: AnyObject {
    var presenter: ImageViewToPresenterProtocol? {get set}
}

protocol ImagePresenterAssemblyProtocol: AnyObject {
    var viewController: ImagePresenterToViewProtocol? {get set}
    var interactor: ImagePresenterToInteractorProtocol? {get set}
    var router: ImagePresenterToRouterProtocol? {get set}
}

protocol ImageInteractorAssemblyProtocol: AnyObject {
    var presenter: ImageInteractorToPresenterProtocol? {get set}
}
