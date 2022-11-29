//
//  FeedModel.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 27.11.2022.
//

import Foundation
import UIKit

class FeedModel {
    
    private lazy var secretWord = "1"
    
    func chek(test: String) {
        
        if test == secretWord {
            print("func check Correct")
            NotificationCenter.default.post(name: Notification.Name("Correct"), object: nil)
            
        } else if test == "" {
            NotificationCenter.default.post(name: Notification.Name("Is empty"), object: nil)
            print ("Is empty")
        } else {
            NotificationCenter.default.post(name: Notification.Name("Incorrect"), object: nil)
            print("Incorrect")
        }
        

    }
}
