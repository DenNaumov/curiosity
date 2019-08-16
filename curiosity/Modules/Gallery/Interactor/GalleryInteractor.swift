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
 
    func downloadNextPage() {
        currentPage += 1
        downloadImages(atPage: currentPage)
    }

    func downloadImages(atPage page: Int) {
        pageFiles = []
        request(host + "?" + getParamsString(page: page)).responseJSON(completionHandler: imageListRetrieveHandler)
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

    func downloadFirstPageImages() {
        request(host + "?" + getParamsString(page: 1)).responseJSON(completionHandler: imageListRetrieveHandler)
    }

    private func getParamsString(page: Int) -> String {
        var paramsString: String = ""
        for (key, value) in params {
            paramsString += "\(key)=\(value)&"
        }
        paramsString += "page=\(page)"
        return paramsString
    }

    private func imageListRetrieveHandler(response: DataResponse<Any>) {
        switch response.result {
        case .success(let value):
            DispatchQueue.main.async() {
                guard let responseArray = value as? [String: Any] else { return }
                if let responsePhotos = responseArray["photos"] as? [[String: Any]] {
                    var imageList: [URL] = []
                    for photoObject in responsePhotos {
                        guard
                            let urlString = photoObject["img_src"] as? String,
                            let url = URL(string: urlString)
                            else { return }
                        imageList.append(url)
                    }
                    self.imageListRetrieved(imageList)
                } else if
                    let responseError = responseArray["error"] as? [String: Any],
                    let error = responseError["message"] as? String
                {
                    self.presenter?.reportError(error)
                }
            }
        case .failure(let error):
            if currentPage == 1 {
                self.loadOfflineImages()
            }
        }
    }

    private func imageListRetrieved(_ imageList: [URL]) {
        downloadImagesLeft = imageList.count
        for imageURL in imageList {
            downloadImage(from: imageURL)
        }
    }

    private func downloadImage(from url: URL) {
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
