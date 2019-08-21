//
//  ImagePresenter.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import  UIKit

class ImagePresenter: ImagePresenterAssemblyProtocol {

    weak var viewController: ImagePresenterToViewProtocol?
    var interactor: ImagePresenterToInteractorProtocol?
    var router: ImagePresenterToRouterProtocol?
    let photoURL: URL
    
    init(photoURL: URL) {
        self.photoURL = photoURL
    }

}

extension ImagePresenter: ImageViewToPresenterProtocol {
    func readyToShow() {
        viewController?.showImage(from: photoURL)
    }
}

extension ImagePresenter: ImageInteractorToPresenterProtocol {

}
