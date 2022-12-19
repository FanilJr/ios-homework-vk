//
//  PostAPI.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
import UIKit

enum EmptyDataError: Error {
    case emptydata
}

extension EmptyDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptydata:
            return "Не удалось загрузить посты!"
        }
    }
}

final class PostAPI {
    func fetchPosts(_ completion: @escaping (Result<[Post], EmptyDataError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let posts = Self.getPosts() else {
                completion(.failure(.emptydata))
                return
            }
            completion(.success(posts))
        }
    }
    
    static func fakeEmptyPosts() -> [Post]? {
        return nil
    }
    
    static func getPosts() -> [Post]? {
        let posts = [
            Post(id: "1", author: "На концерте живой музыки", image: "P21", description: "Очень понравилось", likes: 240, views: 312),
            Post(id: "2", author: "А это мы 20 октября", image: "P22", description: "Black style", likes: 766, views: 803),
            Post(id: "3", author: "Тюменский мост влюблённых 🌉", image: "P17", description: "«Делаем фоточки", likes: 450, views: 1500),
            Post(id: "4", author: "Вкусно поели 🥞☕️", image: "P18", description: "Реклама запрещена", likes: 10000, views: 45000),
            Post(id: "5", author: "Красотка на сеновале 🌾", image: "P19", description: "Потрясающий вид", likes: 100000, views: 10001),
            Post(id: "6", author: "Попали в грозу 🌪", image: "P20", description: "Еще и в грозу попали", likes: 500, views: 505),
            Post(id: "7", author: "Это моя невеста - Юля ❤️", image: "P1", description: "Еще не знает, что сделаю ей предложение", likes: 1000, views: 1500),
            Post(id: "8", author: "Мы любим вкусно поесть", image: "P16", description: "Ночной жор", likes: 300, views: 320),
            Post(id: "9", author: "Тут мы вышли загорать 🌈☀️", image: "P2", description: "А я пока размышлял как это будет", likes: 600, views: 650),
            Post(id: "10", author: "На этом фото прекрасно всё 💃🏽", image: "P3", description: "На этом фото прекрасно всё", likes: 800, views: 900),
            Post(id: "11", author: "Время: 00:00, Дата: 05.08.22 💍", image: "P4", description: "Тот самый момент когда я стал женихом", likes: 10000, views: 10001),
            Post(id: "12", author: "Следующий день 👑", image: "P5", description: "Она потрясающая", likes: 20000, views: 20001),
            Post(id: "13", author: "А это мы едем в лифте 🌆", image: "P6", description: "В руке должно быть шампанское", likes: 4000, views: 4005),
            Post(id: "14", author: "Семья - Шамсуллины 👩🏽‍❤️‍👨🏽", image: "P7", description: "Не большой дневник", likes: 10000, views: 10000)
        ]
        return posts
    }
}
