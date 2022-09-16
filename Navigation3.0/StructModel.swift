//
//  StructModel.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 02.09.2022.
//

import UIKit

struct FirstPost {
    var title: String
}

struct Post {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}

struct ModelCollection {
        let image: String
}
