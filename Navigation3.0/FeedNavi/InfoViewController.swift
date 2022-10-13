//
//  InfoViewController.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 29.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var alertButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 20, y: 220, width: 250, height: 50))
        button.setTitle("Attention", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = button.frame.height/2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        return button
    }()
        
    @objc private func didTapButton() {
        let alertInfo = UIAlertController(
            title: "End of quest",
            message: "Are you sure?",
            preferredStyle: .actionSheet
        )
        
        let okAction = UIAlertAction(
            title: "Sure",
            style: .default) {
                _ in
            print ("the quest is over")
                }
        
        let cancelAlert = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil)
        
        alertInfo.addAction(okAction)
        alertInfo.addAction(cancelAlert)
        
        self.present(alertInfo, animated: true, completion: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationItems()
        self.view.addSubview(alertButton)
        print("viewDidLoad InfoViewController")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            self.alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.alertButton.heightAnchor.constraint(equalToConstant: 100),
            self.alertButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setupNavigationItems() {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Info"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        navigationItem.titleView = label
        
        if let navigationBar = navigationController?.navigationBar {

            label.widthAnchor.constraint(equalTo: navigationBar.widthAnchor, constant: -140).isActive = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews InfoViewController")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewWillLayoutSubviews InfoViewController")
    }
    
    


}

