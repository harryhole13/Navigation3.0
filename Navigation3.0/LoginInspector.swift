//
//  LoginInspector.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 13.11.2022.
//
import UIKit
import Foundation

struct LoginInspector: LogInViewControllerDelegate {
    
    func check(login: String, pswd: String) -> Bool {
        Checker.shared.check(loginSingle: login, passwordSingle: pswd)
    }
}

