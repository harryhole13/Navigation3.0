//
//  PhotosViewController.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 11.09.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    enum Constant {
        static let numberOfItems:CGFloat = 3
    }
    
    private lazy var randomizerImage: [UIImage] = []
    
    let facad = ImagePublisherFacade()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionPhoto: UICollectionView = {
        let collectionPhoto = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionPhoto.translatesAutoresizingMaskIntoConstraints = false
        collectionPhoto.dataSource = self
        collectionPhoto.delegate = self
        collectionPhoto.register(PhotosTableViewCell.self, forCellWithReuseIdentifier: "Myfeed")
        return collectionPhoto
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        self.title = "Photo Gallery"
        print(#function)
        self.view.addSubview(collectionPhoto)
        self.facad.subscribe(self)
        self.facad.addImagesWithTimer(time: 3, repeat: 10)
        
        NSLayoutConstraint.activate([
            self.collectionPhoto.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionPhoto.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionPhoto.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionPhoto.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
        self.collectionPhoto.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print(#function)
        self.facad.removeSubscription(for: self)
    }

}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        randomizerImage = images
        collectionPhoto.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        randomizerImage.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Myfeed", for: indexPath) as? PhotosTableViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionCell", for: indexPath)
            return cell
        }
        
        let viewImage = randomizerImage[indexPath.row]

        cell.setupImage(with: UIImageView(image: viewImage))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let neededWidth = collectionView.frame.width - (Constant.numberOfItems - 1) * spacing - insets.right - insets.left
        let itemWidth = floor(neededWidth / Constant.numberOfItems)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

    
