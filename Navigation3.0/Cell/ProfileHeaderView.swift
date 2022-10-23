//
//  ViewController.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 26.08.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    var rectangle = 100   //размер авы
    
    private lazy var buttonStatus: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Install status", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        button.backgroundColor = UIColor.blue
        return button
    }()
    
    private lazy var titleName: UILabel = {
        let title = UILabel()
        title.text = "Homelander"
        title.textColor = UIColor.black
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return title
    }()
    
    private lazy var stackNameWithStatus: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var setStatus: UITextField = {
        let setStatus = UITextField()
        setStatus.translatesAutoresizingMaskIntoConstraints = false
        setStatus.leftViewMode = .always
        setStatus.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        setStatus.placeholder =  "Write your status"
        setStatus.clearButtonMode = .whileEditing
        setStatus.backgroundColor = .white
        setStatus.clipsToBounds = true
        setStatus.layer.cornerRadius = 12
        setStatus.layer.borderWidth = 1
        setStatus.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        setStatus.font = .systemFont(ofSize: 14, weight: .regular)
        setStatus.textColor = .black
        return setStatus
    }()

   private var statusText = "Inhuman fucking monster" //первичный статус
            
    private lazy var titleStatus: UILabel = {
        var title = UILabel()
        title.text = statusText
        title.textColor = UIColor.gray
        title.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return title
    }()

    lazy var avatarImageView: UIImageView = {
        let picture = UIImage(named: "homelander")
        let avatarView = UIImageView(image: UIImage(named: "Homelander"))
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.isUserInteractionEnabled = true
        avatarView.clipsToBounds = true
        avatarView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        avatarView.layer.borderWidth = 3
        avatarView.contentMode = .scaleAspectFill
        avatarView.layer.cornerRadius = CGFloat(rectangle) / 2
        return avatarView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.tintColor = .yellow
        self.addSubview(avatarImageView)
        self.addSubview(stackNameWithStatus)
        self.addSubview(buttonStatus)
        self.addSubview(setStatus)
        self.stackNameWithStatus.addArrangedSubview(titleName)
        self.stackNameWithStatus.addArrangedSubview(titleStatus)
        
        self.setupSnapKitView()
//        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func pressButton() {
        if setStatus.text?.isEmpty == true {
            self.titleStatus.text = "No status"
        } else {
        self.titleStatus.text = setStatus.text
        }
        
        print("pushthebutton")
        self.animateButton(view: buttonStatus)
    }
    
    private func animateButton(view viewToAnimate: UIView) {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 0.5,
            options: .curveEaseIn,
            animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { _ in
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 2,
            options: .curveEaseIn,
            animations: {
            viewToAnimate.transform = .identity
            }, completion: nil)
        }
    }
    
    private func setupSnapKitView(){
        
        self.avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(16)
            make.width.equalTo(CGFloat(rectangle))
            make.height.equalTo(CGFloat(rectangle))
        }
        
        self.stackNameWithStatus.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(27)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.leading.equalTo(self.avatarImageView.snp.trailing).offset(16)
            make.bottom.equalTo(self.setStatus.snp.top).offset(-16)
           
        }
        
        self.setStatus.snp.makeConstraints { make in
            make.top.equalTo(self.stackNameWithStatus.snp.bottom).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.leading.equalTo(self.stackNameWithStatus.snp.leading)
            make.height.equalTo(40)
        }
        
        self.buttonStatus.snp.makeConstraints { make in
            make.top.equalTo(self.setStatus.snp.bottom).offset(16)
            make.trailing.equalTo(self.snp.trailing).offset(-16)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.height.equalTo(50)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
        }
        
    }
    
    private func setupView(){
       
        NSLayoutConstraint.activate([
            self.avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: CGFloat(rectangle)) ,
            self.avatarImageView.heightAnchor.constraint(equalToConstant: CGFloat(rectangle)),
            
            self.stackNameWithStatus.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            self.stackNameWithStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.stackNameWithStatus.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            self.stackNameWithStatus.bottomAnchor.constraint(equalTo: setStatus.topAnchor, constant: -16),
//
            self.setStatus.topAnchor.constraint(equalTo: stackNameWithStatus.bottomAnchor, constant: 16),
            self.setStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.setStatus.leadingAnchor.constraint(equalTo: self.stackNameWithStatus.leadingAnchor),
            self.setStatus.heightAnchor.constraint(equalToConstant: 40),

            self.buttonStatus.topAnchor.constraint(equalTo: setStatus.bottomAnchor, constant: 16),   ///warning
            self.buttonStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.buttonStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.buttonStatus.heightAnchor.constraint(equalToConstant: 50),
            self.buttonStatus.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}
    
    

 


