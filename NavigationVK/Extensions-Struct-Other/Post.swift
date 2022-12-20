//
//  Post.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import Foundation

public struct Post: Equatable {
    public let id: String
    public let author: String
    public let image: String
    public let description: String
    public let likes: Int
    public let views: Int
    
    public init(id: String, author: String, image: String, description: String, likes: Int, views: Int) {
        self.id = id
        self.author = author
        self.image = image
        self.description = description
        self.likes = likes
        self.views = views
    }
}
