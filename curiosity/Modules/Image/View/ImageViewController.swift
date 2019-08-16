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

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private var previewImageView: ImageZoomView? = nil
    
    init(photo: URL) {
        super.init(nibName: nil, bundle: nil)
        
        guard
            let imageData = NSData(contentsOf: photo),
            let image = UIImage(data: imageData as Data)
            else { return }
        
        previewImageView = ImageZoomView(frame: .zero, image: image)
        view.addSubview(previewImageView!)
        previewImageView!.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageViewController: ImagePresenterToViewProtocol {

}
