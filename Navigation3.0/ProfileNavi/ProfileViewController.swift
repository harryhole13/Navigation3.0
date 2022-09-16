//
//  ProfileViewController.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 28.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return statusBarHeight
    }
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Post Cell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default Cell")
        tableView.register(CollectionView.self, forCellReuseIdentifier: "CollectionFeed")
        tableView.backgroundColor = .lightGray
        return tableView
    }()
    
    
    lazy private var rectangleCopy = ProfileHeaderView()  // чтобы из одного места брать размер авы
    
    lazy private var xMark: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.transform = CGAffineTransform(scaleX: 2, y: 2)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeFullScreen), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        button.layer.opacity = 0
        return button
    }()
    
    @objc private func closeFullScreen() {
        print("click x")
        self.copyAvatar.isUserInteractionEnabled = true
        self.viewBlur.isUserInteractionEnabled = false
        self.xMark.isUserInteractionEnabled = false
        self.viewBlur.layer.opacity = 0
        self.xMark.layer.opacity = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.copyAvatar.layer.cornerRadius = CGFloat(self.rectangleCopy.rectangle) / 2
                self.copyAvatar.transform = .identity
                self.copyAvatar.center = CGPoint(x: 66 , y: 66 + self.getStatusBarHeight())
                NSLayoutConstraint.activate(self.setupCopyAvatarConstraint())
            },
            completion: nil
        )
        
    }
    
    lazy private var viewBlur: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .black
        view.layer.opacity = 0
        return view
    }()
    
    private lazy var copyAvatar: UIImageView = {
        let picture = UIImage(named: "homelander")
        let avatarView = UIImageView(image: UIImage(named: "Homelander"))
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.clipsToBounds = true
        avatarView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        avatarView.layer.borderWidth = 3
        avatarView.contentMode = .scaleAspectFill
        avatarView.layer.cornerRadius = CGFloat(rectangleCopy.rectangle) / 2
        return avatarView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.view.addSubview(tableView)
        self.view.addSubview(viewBlur)
        self.view.addSubview(copyAvatar)
        self.view.addSubview(xMark)
        NSLayoutConstraint.activate(setupTableVIew())
        NSLayoutConstraint.activate(setupCopyAvatarConstraint())
        NSLayoutConstraint.activate(setupXMark())
        
        self.setupViewBlur()
        self.navigationController?.isNavigationBarHidden = false
        self.setupGesture()
    }
    
    private func setupTableVIew() -> [NSLayoutConstraint] {
        let topAnchor = self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingAnchor = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomAnchor = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        return [
            topAnchor, leadingAnchor, trailingAnchor, bottomAnchor
        ]
    }
    
    private func setupXMark() -> [NSLayoutConstraint] {
        let topAnchor = self.xMark.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 16 )
        let trailingAnchor = self.xMark.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let width =  self.xMark.widthAnchor.constraint(equalToConstant: 32)
        let height = self.xMark.heightAnchor.constraint(equalToConstant: 32)
        return [
            topAnchor, trailingAnchor, width, height
        ]
    }
    
    private func setupViewBlur() {
        viewBlur.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func setupCopyAvatarConstraint() -> [NSLayoutConstraint] {
        let topAnchor = self.copyAvatar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 16 )
        let leadingAnchor = self.copyAvatar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let width =  self.copyAvatar.widthAnchor.constraint(equalToConstant: CGFloat(rectangleCopy.rectangle))
        let height = self.copyAvatar.heightAnchor.constraint(equalToConstant: CGFloat(rectangleCopy.rectangle))
        return [
            topAnchor, leadingAnchor, width, height
        ]
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(tapAction))
        self.copyAvatar.isUserInteractionEnabled = true
        self.copyAvatar.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func tapAction() {
         print("click ava")
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                
                self.copyAvatar.layer.cornerRadius = 0
                self.copyAvatar.transform = CGAffineTransform(scaleX: UIScreen.main.bounds.width/CGFloat(Float(self.rectangleCopy.rectangle)), y: UIScreen.main.bounds.width/CGFloat(self.rectangleCopy.rectangle))
                self.copyAvatar.center = self.viewBlur.center
                self.viewBlur.alpha = 0.5

            },
            completion: {_ in

                self.copyAvatar.isUserInteractionEnabled = false
                self.viewBlur.isUserInteractionEnabled = true
                self.xMark.isUserInteractionEnabled = true
                self.xMark.layer.opacity = 1
               
                
            }
        )
        
    }
   
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
        return 1 } else {
            return dataBase.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? ProfileHeaderView
                    
            else {
                return UITableViewHeaderFooterView()
            }
        
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionFeed", for: indexPath) as? CollectionView else { return UITableViewCell() }
            cell.imageArrowButton.tag = indexPath.row
            cell.imageArrowButton .addTarget(self, action: #selector(showCollection), for: .touchUpInside)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
            let post = dataBase[indexPath.row]
            cell.setupWithData(with: post)
            return cell
        }
        
    }
    
    @objc private func showCollection() {
        navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
    
}
