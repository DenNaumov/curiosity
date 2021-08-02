//
//  GalleryEntity.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import Foundation

class ImageFile {

    private let content: NSData

    init(from url: URL) {
        guard let imageContent = NSData(contentsOf: url) else { fatalError() }
        content = imageContent
    }
    
    public func getContent() -> NSData {
        return content
    }
}
