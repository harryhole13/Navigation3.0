//
//  FeedViewController.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 28.08.2022.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    var myFirstPost =  FirstPost(title: "Kukareku")
    
    lazy private var postButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(showPostModal), for: .touchUpInside)
        return button
    }()
    
    @objc private func showPostModal() {
        navigationController?.pushViewController(PostViewController(), animated: true)
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.view.addSubview(postButton)
        print("feed")
       
        NSLayoutConstraint.activate([
            self.postButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.postButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.postButton.heightAnchor.constraint(equalToConstant: 100),
            self.postButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}
