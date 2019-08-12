//
//  GalleryViewController.swift
//  curiosity
//
//  Created on 10/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, GalleryViewAssemblyProtocol {

    var presenter: GalleryViewToPresenterProtocol?

    let collectionView: UICollectionView
    let reuseIdentifier = "reuseIdentifier"
    var allPhotoURLs: [URL] = []
    
    struct Appearance {
        static let cellHeight = 150
        static let cellWidth = 150
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.center.width.height.equalToSuperview()
        }
        collectionView.dataSource = self
        collectionView.delegate = self

        view.backgroundColor = .white
        presenter?.readyToShow()
    }
}

extension GalleryViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = allPhotoURLs[indexPath.row]
        presenter?.openImage(photo)

    }
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotoURLs.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCollectionViewCell

        cell.backgroundColor = .white
        cell.setup(with: allPhotoURLs[indexPath.row])

        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler))
        longPressRecognizer.minimumPressDuration = 1.0
        cell.addGestureRecognizer(longPressRecognizer)

        return cell
    }

}

extension GalleryViewController: GalleryPresenterToViewProtocol {

    func addImages(_ urls: [URL]) {
        let oldCount = allPhotoURLs.count
        let addedCount = urls.count
        var indexes: [IndexPath] = []
        for i in oldCount...(oldCount + addedCount - 1) {
            indexes.append(IndexPath(item: i, section: 0))
        }
        allPhotoURLs = urls
//        collectionView.insertItems(at: indexes)
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Appearance.cellWidth, height: Appearance.cellHeight)
    }
}

extension GalleryViewController {
    
    @objc func longPressHandler(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state == .began {
            let pointLocation = gestureReconizer.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: pointLocation) {
                allPhotoURLs.remove(at: indexPath.row)
                collectionView.deleteItems(at: [indexPath])
            }
        }
    }
}
