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
        post.append(PostStruct(author: "Тюменский мост влюблённых 🌉", description: "Делаем фоточки", image: "P17", likes: 0, views: 0))
        post.append(PostStruct(author: "Вкусно поели 🥞☕️", description: "Реклама запрещена", image: "P18", likes: 0, views: 0))
        post.append(PostStruct(author: "Красотка на сеновале 🌾", description: "Потрясающий вид", image: "P19", likes: 0, views: 0))
        post.append(PostStruct(author: "Попали в грозу 🌪", description: "P.S. еще и колесо пробили", image: "P20", likes: 0, views: 0))
        post.append(PostStruct(author: "Это моя невеста - Юля ❤️", description: "Ещё не знает, что сделаю ей предложение", image: ("P1"), likes: 0, views: 0))
        post.append(PostStruct(author: "Мы любим вкусно поесть", description: "Ночной жор", image: "P16", likes: 0, views: 0))
        post.append(PostStruct(author: "Тут мы вышли загорать 🌈☀️", description: "А я пока размышлял как это будет", image: ("P2"), likes: 0, views: 0))
        post.append(PostStruct(author: "На этом фото прекрасно всё 💃🏽", description: "p.s. Сзади мой авто", image: ("P3"), likes: 0, views: 0))
        post.append(PostStruct(author: "Время: 00:00, Дата: 05.08.22 💍", description: "Тот самый момент, когда я стал женихом 🕺🏽", image:  ("P4"), likes: 0, views: 0))
        post.append(PostStruct(author: "Следующий день 👑", description: "Она потрясающая", image: ("P5"), likes: 0, views: 0))
        post.append(PostStruct(author: "А это мы едем в лифте 🌆", description: "В руке должно быть шампанское", image: ("P6"), likes: 0, views: 0))
        post.append(PostStruct(author: "Семья - Шамсуллины 👩🏽‍❤️‍👨🏽", description: "Небольшой дневник", image: ("P7"), likes: 0, views: 0))
                
        return post
    }
}
