//
//  StructModel.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 02.09.2022.
//

import UIKit

public struct FirstPost {
    
    public var title: String
    public init(title: String) {
        self.title = title
    }
}

public struct Post {
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
    public init(author: String, description: String, image: String, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}

public struct ModelCollection {
    public let image: String
    public init(image: String) {
        self.image = image
    }
}


