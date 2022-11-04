//
//  PostTableViewCellModel.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 31.10.2022.
//

import Foundation
import UIKit

class PostTbaleViewCellModel {
    
    var post: PostStruct
    
    var author: String {
        return post.author
    }
    var description: String {
        return post.description
    }
    var image: String {
        return post.image
    }
    var likes: Int {
        return post.likes
    }
    var views: Int {
        return post.views
    }
    
    init(post: PostStruct) {
        self.post = post
    }
}
