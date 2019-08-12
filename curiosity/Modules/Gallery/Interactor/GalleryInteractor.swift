//
//  GalleryInteractor.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import Foundation

class GalleryInteractor: GalleryInteractorAssemblyProtocol {
    weak var presenter: GalleryInteractorToPresenterProtocol?

}

extension GalleryInteractor: GalleryPresenterToInteractorProtocol {

    func loadImages() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            presenter?.setURLs(fileURLs)
        } catch {
            print(error)
        }
    }
}
