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
            Post(
                id: "1",
                author: "На концерте живой музыки",
                image: "P21",
                description: "Очень понравилось",
                likes: 240,
                views: 312
            ),
            Post(
                id: "2",
                author: "А это мы 20 октября",
                image: "P22",
                description: "Black style",
                likes: 766,
                views: 893
            ),
            Post(
                id: "3",
                author: "Тюменский мост влюблённых 🌉",
                image: "P17",
                description: "«Делаем фоточки",
                likes: 450,
                views: 1500
            ),
            Post(
                id: "4",
                author: "Вкусно поели 🥞☕️",
                image: "P18",
                description: "Реклама запрещена",
                likes: 10000,
                views: 45000
            ),
            Post(id: "5",
                 author: "Красотка на сеновале 🌾",
                 image: "P19",
                 description: "Потрясающий вид",
                 likes: 100000, views: 10001)
        ]
        return posts
    }
}
