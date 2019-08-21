//
//  CollectionViewCell.swift
//  maps
//
//  Created by Денис Наумов on 05/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    var imageView: UIImageView? = nil

    func setup(with fileURL: URL) {
        guard let imageData = NSData(contentsOf: fileURL) else { return }
        let image = UIImage(data: imageData as Data)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
        self.imageView = imageView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.removeFromSuperview()
        if let gestureRecognizer = gestureRecognizers?.first {
            removeGestureRecognizer(gestureRecognizer)
        }
    }
}
