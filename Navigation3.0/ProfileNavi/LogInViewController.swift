//
//  LogInViewController.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 30.08.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    lazy private var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 906)
            return scroll
    }()
    
    private lazy  var logoImage: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "logo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.clipsToBounds = true
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    private lazy var logInButton: UIButton = {
        let image = UIImage(named: "blue_pixel")
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()
    
    @objc func logIn() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
        switch logInButton.state {
        case .normal:
                print("Normal")
            logInButton.alpha = 1
        case .highlighted:
                print("highlighted")
            logInButton.alpha = 0.8
        case .selected:
                print("selected")
            logInButton.alpha = 0.8
        case .disabled:
                print("disabled")
            logInButton.alpha = 0.8
        default:
                print("default")
            logInButton.alpha = 1
            }
    }
    
    private lazy var enterEmail: UITextField = {
        let email = UITextField()
        email.placeholder = "Email of phone"
        email.leftView = .init(frame: CGRect(x: 0, y: 0, width: 16, height: 10))
        email.leftViewMode = .always
        email.textColor = .black
        email.tag = 0
        email.font = .systemFont(ofSize: 16)
        email.layer.borderColor = UIColor.lightGray.cgColor
        email.layer.borderWidth = 0.5
        email.tintColor = UIColor(named: "Accent Color")
        email.autocapitalizationType = .none
        email.backgroundColor = .systemGray6
        return email
    }()
    
    private lazy var enterPassword: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.leftView = .init(frame: CGRect(x: 0, y: 0, width: 16, height: 10))
        password.leftViewMode = .always
        password.textColor = .black
        password.tag = 0
        password.font = .systemFont(ofSize: 16)
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.5
        password.tintColor = UIColor(named: "Accent Color")
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        password.backgroundColor = .systemGray6
        return password
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.layer.cornerRadius = 10
        stack.clipsToBounds = true
        return stack
    }()
   
    private var login: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(scroll)
        self.navigationController?.navigationBar.isHidden = true
        self.scroll.addSubview(logoImage)
        self.scroll.addSubview(logInButton)
        self.scroll.addSubview(stackView)
        self.stackView.addArrangedSubview(enterEmail)
        self.stackView.addArrangedSubview(enterPassword)
        setupGestures()
        
        NSLayoutConstraint.activate([
            self.scroll.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scroll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scroll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scroll.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.logoImage.topAnchor.constraint(equalTo: self.scroll.topAnchor, constant: 120),
            self.logoImage.centerXAnchor.constraint(equalTo: self.scroll.centerXAnchor),
            self.logoImage.widthAnchor.constraint(equalToConstant: 100),
            self.logoImage.heightAnchor.constraint(equalToConstant: 100),
            
            self.logInButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16),
            self.logInButton.leadingAnchor.constraint(equalTo: self.scroll.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.logInButton.trailingAnchor.constraint(equalTo: self.scroll.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.stackView.leadingAnchor.constraint(equalTo: self.scroll.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.scroll.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.stackView.heightAnchor.constraint(equalToConstant: 100),
            self.stackView.topAnchor.constraint(equalTo: self.logoImage.bottomAnchor, constant: 120),
        ])

    }
    
    private func setupGestures() {
        let anyTap = UITapGestureRecognizer(target: self, action: #selector(forceHidingKeyaboard))
        self.view.addGestureRecognizer(anyTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showKeyboard),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(hideKeyboard),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
    @objc private func showKeyboard(_ notification: Notification) {
        if let keyboardFrame:NSValue =
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let lowestPointButtonY = self.logInButton.frame.origin.y + self.logInButton.frame.height    // нижняя координат Y  у кнопки
            let highestPointKeyboardY = keyboardRectangle.origin.y // верхняя координа У у клавы
            let isScrollMoveY = highestPointKeyboardY < lowestPointButtonY
            ? lowestPointButtonY - highestPointKeyboardY : 0
            self.scroll.contentOffset = CGPoint(x: 0, y: isScrollMoveY)
        }
    }
    
    @objc private func hideKeyboard(_ notification: Notification) {
        self.forceHidingKeyaboard()
    }
    
    @objc private func forceHidingKeyaboard(){
        self.view.endEditing(true)
        self.scroll.setContentOffset(.zero, animated: true)
    }

}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        ()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("🍋 \(textField.text!)")
        if textField.tag == 0 {
            self.login = textField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.forceHidingKeyaboard()
        return true
    }
}
