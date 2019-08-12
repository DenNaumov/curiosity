//
//  LoadingInteractor.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import Alamofire

class LoadingInteractor: LoadingInteractorAssemblyProtocol {
    weak var presenter: LoadingInteractorToPresenterProtocol?
    let host = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"
    let params: [String: Any] = ["sol": 100, "page": 1, "api_key": "DEMO_KEY"]
    var downloadImagesLeft = 0
}

extension LoadingInteractor: LoadingPresenterToInteractorProtocol {

    func downloadImages() {
        request(host + "?" + getParamsString()).responseJSON(completionHandler: imageListRetrieveHandler)
    }

    private func imageListRetrieveHandler(response: DataResponse<Any>) {
        switch response.result {
        case .success(let value):
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
                DispatchQueue.main.async() {
                    self.imageListRetrieved(imageList)
                }
            } else if
                let responseError = responseArray["error"] as? [String: Any],
                let error = responseError["message"] as? String
            {
                presenter?.reportError(error)
            }
        case .failure(let error):
            presenter?.reportError("Connection Error")
        }
    }
    
    private func imageListRetrieved(_ imageList: [URL]) {
        downloadImagesLeft = imageList.count
        for imageURL in imageList {
            downloadImage(from: imageURL)
        }
    }

    private func getParamsString() -> String {
        var paramsString: String = ""
        for (key, value) in params {
            paramsString += "\(key)=\(value)&"
        }
        return paramsString
    }
    
    private func downloadImage(from url: URL) {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        getData(from: url) { location, response, error in
            guard let location = location else {
                 print("download error")
                return
            }
            do {
                DispatchQueue.main.async() {
                    self.downloadImageFinished()
                }
                try FileManager.default.moveItem(at: location, to: documents.appendingPathComponent(response?.suggestedFilename ?? url.lastPathComponent))
                } catch {
                   print(error)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (URL?, URLResponse?, Error?) -> ()) {
        URLSession.shared.downloadTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImageFinished() {
        downloadImagesLeft -= 1
        if downloadImagesLeft == 0 {
            presenter?.imagesDownloadFinished()
        }
    }
}
