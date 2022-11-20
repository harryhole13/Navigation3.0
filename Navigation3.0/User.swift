//
//  User.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 12.11.2022.
//
import UIKit
import Foundation

protocol UserService {
    func pushUser(login: String) -> User?
}

class User {
    
    var login = String()
    var fullName = String()
    var avatar = UIImage()
    var status = String()
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
    
}

class TestUserService: UserService {
    
    static let user = TestUserService()
    
    func pushUser(login: String) -> User? {
        testUser
    }
    
    private var testUser = User(login: "Test", fullName: "TestName", avatar: UIImage(named: "test")!, status: "debug session")
}


class CurrentUserService: UserService {
    private init() {}
    static let shared = CurrentUserService()
    
    func pushUser(login: String) -> User? {
        return currentUser.login == login ? currentUser: nil //тернарный
    }
    
    private var currentUser = User(login: "a", fullName: "Potemin", avatar: UIImage(named: "Brad")!, status: "I am New Homelander")
}

