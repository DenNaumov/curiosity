//
//  Controller.swift
//  nasa-api
//
//  Created by Денис Наумов on 18.08.2022.
//

import UIKit

protocol CollectionDelegate: AnyObject {
    func didRecieveImageList(data: ServerResponse)
    func didRecieveImage(data: Data)
    func didFailRecieveImageList(withError: Error)
    func didFailRecieveImage(withError: Error)
}

class CollectionController {
    weak var delegate: CollectionDelegate?
    
    let network = NetworkService()
    
    func fetchData() {
        
        let url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=100&api_key=DEMO_KEY"
        network.requestJson(from: url, using: ServerResponse.self) { (result) in

            switch result {
            case .success(let data):
                self.delegate?.didRecieveImageList(data: data)
            case .failure(let error):
                self.delegate?.didFailRecieveImageList(withError: error)
                print(error)
            }
        }
    }
    
    func fetchImage(forIndex: Int) {
        print(forIndex)
    }
    
    func downloadImageFrom(_ url: URL) {
        network.request(from: url.absoluteString) { result in
            switch result {
            case .success(let data):
                self.delegate?.didRecieveImage(data: data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
