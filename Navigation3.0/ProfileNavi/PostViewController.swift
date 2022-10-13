//
//  PostViewController.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 28.08.2022.
//

import UIKit

class PostViewController: UIViewController {

    private var titlePost: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Post Post Post"
        title.backgroundColor = .white
        title.textColor = .black
        title.textAlignment = .center
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        self.view.addSubview(titlePost)
        lazy var superNavi = FeedViewController()
        print("postviewcontroller")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(self.didTapButton))
//        titlePost.text = superNavi.myFirstPost.title
       
        NSLayoutConstraint.activate([
            self.titlePost.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titlePost.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.titlePost.widthAnchor.constraint(equalToConstant: 80),
            self.titlePost.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func didTapButton() {
        let infoVC = UINavigationController(rootViewController: InfoViewController())
        self.present(infoVC, animated: true, completion: nil)
    }
}
