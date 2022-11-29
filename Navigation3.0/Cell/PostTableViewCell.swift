//
//  PhotosTableViewCell.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 06.09.2022.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {

    private lazy var authorCell:UILabel = {
        let string = UILabel()
        string.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        string.textColor = .black
        string.numberOfLines = 2
        string.translatesAutoresizingMaskIntoConstraints = false
        return string
    }()
    
    private lazy var descriptionCell:UILabel = {
        let string = UILabel()
        string.numberOfLines = 0
        string.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        string.textColor = .systemGray
        string.backgroundColor = .white
        string.translatesAutoresizingMaskIntoConstraints = false
        return string
    }()
    
    private lazy var imageCell:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 70, height: 70))
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var randomInt = Int.random(in: 0..<3000)
    
    private lazy var likes:UILabel = {
        let likes = UILabel()
        let text = "Likes: "
        likes.textAlignment = .left
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.textColor = .black
        likes.numberOfLines = 1
        likes.text = text + String(randomInt)
        return likes
    }()
    
    private lazy var views:UILabel = {
        let views = UILabel()
        let text = "Views: "
        views.textAlignment = .right
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.textColor = .black
        views.numberOfLines = 1
        
        let int = Int.random(in: randomInt..<5000)
        views.text = text + String(int)
        return views
    }()
    
    private lazy var stackLikesAndView:UIStackView = {
       let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        self.tintColor = .blue
        self.addSubview(authorCell)
        self.addSubview(imageCell)
        self.addSubview(descriptionCell)
        self.addSubview(stackLikesAndView)
        self.stackLikesAndView.addArrangedSubview(likes)
        self.stackLikesAndView.addArrangedSubview(views)
        
        NSLayoutConstraint.activate([
            self.authorCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.authorCell.bottomAnchor.constraint(equalTo: imageCell.topAnchor, constant: -12),
            self.authorCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.authorCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            self.imageCell.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageCell.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageCell.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            self.imageCell.bottomAnchor.constraint(equalTo: self.descriptionCell.topAnchor, constant: -16),
            
            self.descriptionCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.descriptionCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.descriptionCell.bottomAnchor.constraint(equalTo: self.stackLikesAndView.topAnchor, constant: -16),
            
            self.stackLikesAndView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.stackLikesAndView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.stackLikesAndView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
    }
    
    func setupWithData(with post: Post) {
        authorCell.text = post.author
        imageCell.image = UIImage(named: post.image)
        descriptionCell.text = post.description
    }

}
