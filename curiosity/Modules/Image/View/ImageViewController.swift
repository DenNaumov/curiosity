//
//  ImageViewController.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit
import SnapKit

class ImageViewController: UIViewController, ImageViewAssemblyProtocol {

    var presenter: ImageViewToPresenterProtocol?
    private var previewImageView: ImageZoomView? = nil

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.readyToShow()
    }

    func showImage(from localURL: URL) {

        guard
            let imageData = NSData(contentsOf: localURL),
            let image = UIImage(data: imageData as Data)
            else { return }
        
        previewImageView = ImageZoomView(frame: .zero, image: image)
        view.addSubview(previewImageView!)
        previewImageView?.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension ImageViewController: ImagePresenterToViewProtocol {

}
