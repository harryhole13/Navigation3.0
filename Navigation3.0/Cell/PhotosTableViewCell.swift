//
//  PhotosTableViewCell.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 11.09.2022.
//

import UIKit
import StorageService

class PhotosTableViewCell: UICollectionViewCell {
    
    private lazy var photoView:UIImageView = {
        
        let image = UIImageView(image: UIImage())
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .black
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(photoView)
        
        NSLayoutConstraint.activate([
            self.photoView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.photoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.photoView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.photoView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func setup(with photo: ModelCollection) {
        self.photoView.image = UIImage(named: photo.image)
        }
}
