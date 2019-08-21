//
//  GalleryInteractor.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import Alamofire
import Foundation

class GalleryInteractor: GalleryInteractorAssemblyProtocol {
    weak var presenter: GalleryInteractorToPresenterProtocol?
    private let host = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"
    private let params: [String: Any] = ["sol": 100, "api_key": "DEMO_KEY"]
    private let fileManager = FileManager.default
    private var downloadImagesLeft = 0
    private var currentPage = 1
    private var pageFiles: [String] = []
}

extension GalleryInteractor: GalleryPresenterToInteractorProtocol {
 
    func downloadFirstPageImages() {
        request(host + "?" + getParamsString(page: 1)).responseData(completionHandler: imageListRetrieveHandler)
    }
    
    func downloadNextPageImages() {
        currentPage += 1
        pageFiles = []
        request(host + "?" + getParamsString(page: currentPage)).responseData(completionHandler: imageListRetrieveHandler)
    }

    func loadSavedImages() {
        var fileURLs: [URL] = []
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        for fileName in pageFiles {
            let fileURL = URL(fileURLWithPath: fileName, relativeTo: documentDirectory)
            fileURLs.append(fileURL)
        }
        if currentPage == 1 {
            presenter?.didFinishDownloadInitialImages(fileURLs)
        } else {
            presenter?.didFinishDownloadUpdate(fileURLs)
        }
    }

    func loadOfflineImages() {
        do {
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let filesInDocuments = try fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
            presenter?.didLoadSavedImages(filesInDocuments)
        } catch {
            print(error)
        }
    }

    private func getParamsString(page: Int) -> String {
        var paramsString: String = ""
        for (key, value) in params {
            paramsString += "\(key)=\(value)&"
        }
        paramsString += "page=\(page)"
        return paramsString
    }

    private func imageListRetrieveHandler(response: DataResponse<Data>) {
        switch response.result {
        case .success(let value):
            let responseData: ServerResponseData = try! JSONDecoder().decode(ServerResponseData.self, from: value)
            responseData.photos.forEach { (photo) in
            }
            self.imageListRetrieved(responseData.photos)
        case .failure(let error):
            if currentPage == 1 {
                self.loadOfflineImages()
            }
        }
    }

    private func imageListRetrieved(_ imageList: [CuriosityPhoto]) {
        downloadImagesLeft = imageList.count
        for image in imageList {
            downloadImage(image)
        }
    }

    private func downloadImage(_ imageData: CuriosityPhoto) {
        let url = imageData.remoteURL
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        getData(from: url) { [unowned self] location, response, error in
            guard let location = location else {
                print("download error")
                return
            }
            do {
                DispatchQueue.main.async() {
                    self.downloadImageFinished()
                }
                let filename = response?.suggestedFilename ?? url.lastPathComponent
                self.pageFiles.append(filename)
                try self.fileManager.moveItem(at: location, to: documentDirectory.appendingPathComponent(filename))
            } catch {
                print(error)
            }
        }
    }

    private func getData(from url: URL, completion: @escaping (URL?, URLResponse?, Error?) -> ()) {
        URLSession.shared.downloadTask(with: url, completionHandler: completion).resume()
    }

    private func moveItemToDocuments(at: URL, to: String) throws {
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        try fileManager.moveItem(at: at, to: documentDirectory.appendingPathComponent(to))
    }

    private func downloadImageFinished() {
        downloadImagesLeft -= 1
        if downloadImagesLeft == 0 {
            loadSavedImages()
        }
    }    
}
