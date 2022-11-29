//
//  CustomButton.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 24.11.2022.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    private lazy var tittle: String = {
        return ""
    }()
    
    private lazy var tittleColor: UIColor = {
        let color:UIColor = .green
        return color
    }()
    
    private let actionTap: () -> ()
    
    func setColourRed() {
        self.setBackgroundImage(nil, for: .normal)
        self.backgroundColor = .red
        self.setTitle("Incorrect", for: .normal)
        print("try change colour")
    }
    
    func setColourGreen() {
        self.setBackgroundImage(nil, for: .normal)
        self.backgroundColor = .green
        self.setTitle("Correct", for: .normal)
      
    }
    
    func setIsEmpty() {
        self.setBackgroundImage(nil, for: .normal)
        self.backgroundColor = .orange
        self.setTitle("Field is EMPTY!!!", for: .normal)
        
    }
    
    init(tittle: String, tittleColor: UIColor, actionTap: @escaping () -> ()) {
        
        self.actionTap = actionTap
        super.init(frame: .zero)
        self.setTitle(tittle, for: .normal)
        self.setTitleColor(tittleColor, for: .normal)
        self.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.layer.cornerRadius = 12
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.clipsToBounds = true
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        print("tapCustom")
        actionTap()
    }
}
