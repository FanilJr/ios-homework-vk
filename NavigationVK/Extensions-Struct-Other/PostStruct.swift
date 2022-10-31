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
    var id: String

    // MARK: Создаём массив с помощью функции
    static func massivePost() -> [PostStruct] {
        
        var post = [PostStruct]()
        post.append(PostStruct(author: "Тюменский мост влюблённых 🌉", description: "Делаем фоточки", image: "P17", likes: 0, views: 0, id: "1"))
        post.append(PostStruct(author: "Вкусно поели 🥞☕️", description: "Реклама запрещена", image: "P18", likes: 0, views: 0, id: "2"))
        post.append(PostStruct(author: "Красотка на сеновале 🌾", description: "Потрясающий вид", image: "P19", likes: 0, views: 0, id: "3"))
        post.append(PostStruct(author: "Попали в грозу 🌪", description: "P.S. еще и колесо пробили", image: "P20", likes: 0, views: 0, id: "4"))
        post.append(PostStruct(author: "Это моя невеста - Юля ❤️", description: "Ещё не знает, что сделаю ей предложение", image: ("P1"), likes: 0, views: 0, id: "5"))
        post.append(PostStruct(author: "Мы любим вкусно поесть", description: "Ночной жор", image: "P16", likes: 0, views: 0, id: "6"))
        post.append(PostStruct(author: "Тут мы вышли загорать 🌈☀️", description: "А я пока размышлял как это будет", image: ("P2"), likes: 0, views: 0, id: "7"))
        post.append(PostStruct(author: "На этом фото прекрасно всё 💃🏽", description: "p.s. Сзади мой авто", image: ("P3"), likes: 0, views: 0, id: "8"))
        post.append(PostStruct(author: "Время: 00:00, Дата: 05.08.22 💍", description: "Тот самый момент, когда я стал женихом 🕺🏽", image:  ("P4"), likes: 0, views: 0, id: "9"))
        post.append(PostStruct(author: "Следующий день 👑", description: "Она потрясающая", image: ("P5"), likes: 0, views: 0, id: "10"))
        post.append(PostStruct(author: "А это мы едем в лифте 🌆", description: "В руке должно быть шампанское", image: ("P6"), likes: 0, views: 0, id: "11"))
        post.append(PostStruct(author: "Семья - Шамсуллины 👩🏽‍❤️‍👨🏽", description: "Небольшой дневник", image: ("P7"), likes: 0, views: 0, id: "12"))
                
        return post
    }
}

final class ProfileViewModel {
    
    public var postArray = [PostStruct(author: "На концерте живой музыки", description: "Очень понравилось", image: "P21", likes: 0, views: 0, id: "13"),
                            PostStruct(author: "А это мы 20 октября", description: "black style", image: "P22", likes: 0, views: 0, id: "14"),
                            PostStruct(author: "Тюменский мост влюблённых 🌉", description: "Делаем фоточки", image: "P17", likes: 0, views: 0, id: "1"),
                            PostStruct(author: "Вкусно поели 🥞☕️", description: "Реклама запрещена", image: "P18", likes: 0, views: 0, id: "2"),
                            PostStruct(author: "Красотка на сеновале 🌾", description: "Потрясающий вид", image: "P19", likes: 0, views: 0, id: "3"),
                            PostStruct(author: "Попали в грозу 🌪", description: "P.S. еще и колесо пробили", image: "P20", likes: 0, views: 0, id: "4"),
                            PostStruct(author: "Это моя невеста - Юля ❤️", description: "Ещё не знает, что сделаю ей предложение", image: ("P1"), likes: 0, views: 0, id: "5"),
                            PostStruct(author: "Мы любим вкусно поесть", description: "Ночной жор", image: "P16", likes: 0, views: 0, id: "6"),
                            PostStruct(author: "Тут мы вышли загорать 🌈☀️", description: "А я пока размышлял как это будет", image: ("P2"), likes: 0, views: 0, id: "7"),
                            PostStruct(author: "На этом фото прекрасно всё 💃🏽", description: "p.s. Сзади мой авто", image: ("P3"), likes: 0, views: 0, id: "8"),
                            PostStruct(author: "Время: 00:00, Дата: 05.08.22 💍", description: "Тот самый момент, когда я стал женихом 🕺🏽", image:  ("P4"), likes: 0, views: 0, id: "9"),
                            PostStruct(author: "Следующий день 👑", description: "Она потрясающая", image: ("P5"), likes: 0, views: 0, id: "10"),
                            PostStruct(author: "А это мы едем в лифте 🌆", description: "В руке должно быть шампанское", image: ("P6"), likes: 0, views: 0, id: "11"),
                            PostStruct(author: "Семья - Шамсуллины 👩🏽‍❤️‍👨🏽", description: "Небольшой дневник", image: ("P7"), likes: 0, views: 0, id: "12")
    ]
    
    func numberOfRows() -> Int {
        return postArray.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> PostTbaleViewCellModel? {
        let post = postArray[indexPath.row]
        return PostTbaleViewCellModel(post: post)
    }
    
}
