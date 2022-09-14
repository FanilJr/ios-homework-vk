//
//  PostStruct.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 08.09.2022.
//

import Foundation

struct PostNavigation {
  
    var image: String

    // MARK: Создаём массив с помощью функции
    static func massivePost() -> [PostNavigation] {
        
        var post = [PostNavigation]()
        post.append(PostNavigation(image: "heart3"))
        return post
    }
}
