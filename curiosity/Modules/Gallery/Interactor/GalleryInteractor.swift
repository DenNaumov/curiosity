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
    private var page = 1
    private var pageURLs: [String] = []
}

extension GalleryInteractor: GalleryPresenterToInteractorProtocol {
 
    func downloadNextPage() {
        page += 1
        downloadImages(page: page)
    }

    func downloadImages(page: Int) {
        pageURLs = []
        print("get list on page \(page)")
        request(host + "?" + getParamsString(page: page)).responseJSON(completionHandler: imageListRetrieveHandler)
    }

    private func getParamsString(page: Int) -> String {
        var paramsString: String = ""
        for (key, value) in params {
            paramsString += "\(key)=\(value)&"
        }
        paramsString += "page=\(page)"
        return paramsString
    }

    func loadSavedImages() {
        var fileURLs: [URL] = []
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        for i in pageURLs {
            let fileURL = URL(fileURLWithPath: i, relativeTo: documentDirectory)
            fileURLs.append(fileURL)
        }
        if page == 1 {
            presenter?.didFinishDownloadInitialImages(fileURLs)
        } else {
            presenter?.didFinishDownloadUpdate(fileURLs)
        }
    }

    func loadOfflineImages() {
        do {
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURLs = try fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
    
        } catch {
            print(error)
        }
    }

    func downloadFirstPage() {
        request(host + "?" + getParamsString(page: 1)).responseJSON(completionHandler: imageListRetrieveHandler)
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
                let responseError = responseArray["error"] as? [String: Any]//,
//                let error = responseError["message"] as? String
            {
                print(responseError)
//                presenter?.reportError(error)
            }
            }
        case .failure(let error):
            print(error)
//            presenter?.reportError("Connection Error")
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
                self.pageURLs.append(filename)
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
