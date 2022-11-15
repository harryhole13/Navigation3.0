//
//  MyLoginFactory.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 16.11.2022.
//
import UIKit
import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    
    func makeLoginInspector() -> LoginInspector {
        let addInspector = LoginInspector()
        return addInspector
    }

}
