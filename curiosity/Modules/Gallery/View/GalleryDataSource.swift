//
//  GalleryDataSource.swift
//  curiosity
//
//  Created by Денис Наумов on 14/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit

//    private func downloadImage(from url: URL) {

//        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
//response?.suggestedFilename ??

//        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
//            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            let fileURL = documentsURL.appendPathComponent(url.lastPathComponent)
////let fileURL = url
//            return (fileURL, [.createIntermediateDirectories])
//        }
//
//        Alamofire.download(url, to: destination).response { response in
//            print(response)
////
////            if response.result.isSuccess, let imagePath = response.destinationURL?.path {
////                let image = UIImage(contentsOfFile: imagePath)
////            }
//        }

//        download(destination: destination, url).response { response in
//                print(response)
//
//                if response.result.isSuccess, let imagePath = response.destinationURL?.path {
//                    let image = UIImage(contentsOfFile: imagePath)
//                }
//            }
//            request(.GET, mediaUrl).response() {
////                (_, _, data, _) in
////                let image = UIImage(data: data! as NSData)
////                imageView.image = image
//
//                if let localURL = response.destinationURL {
//
//                    completion?(.success, localURL)
//
//                } else {
//
//                    completion?(.failure, nil)
//                }
//            }
//        }
//        getData(from: url) {[unowned self] location, response, error in
//            print(location, response, error)
//            guard let location = location else {
//                print("download error")
//                return
//            }
//            do {
//                    self.downloadImageFinished()
//                try self.moveItemToDocuments(at: location, to: )
//            } catch {
//                print(error)
//            }
//        }
//    }
