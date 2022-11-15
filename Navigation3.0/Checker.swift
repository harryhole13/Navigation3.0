//
//  Checker.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 12.11.2022.
//
import UIKit
import Foundation

// Делаем синглтон


final class Checker {
    
    static let shared = Checker()
    private init() {
        
    }
    
    private static let login = "Aleksey2022"
    
    private static let password = "qwerty"
    
    func check(loginSingle: String, passwordSingle: String) -> Bool {
        if Checker.login == loginSingle && Checker.password == passwordSingle {
            return true
        } else {
                return false
            }
    }
    
}
