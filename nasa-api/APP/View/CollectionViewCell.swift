//
//  CollectionViewCell.swift
//  nasa-api
//
//  Created by Денис Наумов on 18.08.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private weak var loadingView: UIView?
    private weak var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 13
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLoadingIndicator() {
        let activityIndicatorView = UIView(frame: bounds)
        activityIndicatorView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = activityIndicatorView.center
        activityIndicatorView.addSubview(activityIndicator)
        addSubview(activityIndicatorView)
        loadingView = activityIndicatorView
    }
    
    func deleteLoadingIndicator() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
    func setImage(data: Data) {
        let image = UIImage.init(data: data, scale: 10)
        let imageView = UIImageView(image: image)
        self.imageView = imageView
        addSubview(imageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.removeFromSuperview()
        imageView = nil
        print(subviews.count)
    }
}
