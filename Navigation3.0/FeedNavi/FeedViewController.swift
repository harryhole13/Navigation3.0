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
    
    lazy private var postButton = CustomButton(tittle: "Go to post", tittleColor: .white) {
        self.showPostModal()
    }
    
    lazy private var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        textField.placeholder =  "Write your status"
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .white
        textField.clipsToBounds = true
        textField.text = ""
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        return textField
    }()
    
    lazy private var checkGuessButton = CustomButton(tittle: "checkGuessButton", tittleColor: .white, actionTap: tapCheckCorrect)
    
    lazy private var uiLabel = CustomButton(tittle: "UILabel", tittleColor: .white, actionTap: tapCheckCorrect)
    
    
    lazy private var model = FeedModel()
    
//    lazy private var postButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .green
//        button.addTarget(self, action: #selector(showPostModal), for: .touchUpInside)
//        return button
//    }()
    
    func showPostModal() {
        print("tap showpost")
        navigationController?.pushViewController(PostViewController(), animated: true)
    }
    
    func tapCheckCorrect() {
        model.chek(test: textField.text ?? "")
        NotificationCenter.default.addObserver(self, selector: #selector(setRed), name: Notification.Name("Incorrect"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setGreen), name: Notification.Name("Correct"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setEmpty), name: Notification.Name("Is empty"), object: nil)
    }
    
    @objc func setRed() {
        self.uiLabel.setColourRed()
    }
    
    @objc func setGreen() {
        self.uiLabel.setColourGreen()
    }
    
    @objc func setEmpty() {
        self.uiLabel.setIsEmpty()
    }
    
    
    
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        self.view.addSubview(postButton)
        self.view.addSubview(textField)
        self.view.addSubview(checkGuessButton)
        self.view.addSubview(uiLabel)
        print("feed")
       
        NSLayoutConstraint.activate([
            self.postButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.postButton.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 10),
            self.postButton.heightAnchor.constraint(equalToConstant: 50),
            self.postButton.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.textField.heightAnchor.constraint(equalToConstant: 50),
            self.textField.widthAnchor.constraint(equalToConstant: 200),
        ])

        NSLayoutConstraint.activate([
            self.checkGuessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            self.checkGuessButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            self.checkGuessButton.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        NSLayoutConstraint.activate([
            self.uiLabel.topAnchor.constraint(equalTo: postButton.bottomAnchor, constant: 10),
            self.uiLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.uiLabel.heightAnchor.constraint(equalToConstant: 50),
            self.uiLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        
        
    }
}
