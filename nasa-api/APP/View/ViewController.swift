//
//  ViewController.swift
//  nasa-api
//
//  Created by Денис Наумов on 17.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource = [CuriosityPhoto]()
    
    private let controller = CollectionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        controller.delegate = self
    }
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        controller.fetchData()
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.addLoadingIndicator()
        controller.fetchImage(forIndex: indexPath.row)
        return cell
    }
}

extension ViewController {
    

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 100)
    }
}

extension ViewController: CollectionDelegate {
    func didRecieveImageList(data: ServerResponse) {
        self.dataSource = data.photos
        self.collectionView.reloadData()
    }
    
    func didRecieveImage(data: Data) {
//        cell.deleteLoadingIndicator()
//        cell.setImage(data: data)
    }
    
    func didFailRecieveImageList(withError: Error) {
        
    }
    
    func didFailRecieveImage(withError: Error) {
        
    }
}

