//
//  PreviewVCViewController.swift
//  MyGallery
//
//  Created by Денис Наумов on 07/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit
import SnapKit

class ImageZoomView: UIScrollView {
    var imageView: UIImageView!
    
    convenience init(frame: CGRect, image: UIImage) {
        self.init(frame: frame)

        imageView = UIImageView(image: image)
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        setupScrollView()
    }
}

extension ImageZoomView: UIScrollViewDelegate {
    func setupScrollView() {
        delegate = self
        minimumZoomScale = 0.5
        maximumZoomScale = 2.0
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.zoomScale = 1.0
    }
}
