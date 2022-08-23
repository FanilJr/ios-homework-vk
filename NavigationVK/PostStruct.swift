//
//  PostStruct.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import Foundation
import UIKit

struct PostStruct {
    
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int

    // MARK: Создаём массив с помощью функции
    static func massivePost() -> [PostStruct] {
        
        var post = [PostStruct]()
        
        post.append(PostStruct(author: "Это моя невеста - Юля ❤️", description: "Ещё не знает, что сделаю ей предложение", image: ("P1"), likes: 3346, views: 5211))
        post.append(PostStruct(author: "Тут мы вышли загорать 🌈☀️", description: "А я пока размышлял как это будет", image: ("P2"), likes: 2900, views: 3000))
        post.append(PostStruct(author: "На этом фото прекрасно всё 💃🏽", description: "p.s. Сзади мой авто", image: ("P3"), likes: 5500, views: 5502))
        post.append(PostStruct(author: "Время: 00:00, Дата: 05.08.22 💍", description: "Тот самый момент, когда я стал женихом 🕺🏽", image:  ("P4"), likes: 1200, views: 2500))
        post.append(PostStruct(author: "Следующий день 👑", description: "Она потрясающая", image: ("P5"), likes: 5000, views: 5001))
        post.append(PostStruct(author: "А это мы едем в лифте 🌆", description: "В руке должно быть шампанское", image: ("P6"), likes: 3000, views: 3212))
        post.append(PostStruct(author: "Семья - Шамсуллины 👩🏽‍❤️‍👨🏽", description: "Небольшой дневник", image: ("P7"), likes: 88000, views: 99999))
                
        return post
        
    }
}
