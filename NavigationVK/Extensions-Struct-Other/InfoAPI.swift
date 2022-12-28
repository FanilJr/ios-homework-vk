//
//  InfoAPI.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 26.12.2022.
//

import Foundation
import UIKit

final class InfoAPI {
    func fetchPosts(_ completion: @escaping (Result<[InfoUser], EmptyDataError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let info = Self.getInfo() else {
                completion(.failure(.emptydata))
                return
            }
            completion(.success(info))
        }
    }
    
    static func fakeEmptyPosts() -> [InfoUser]? {
        return nil
    }
    
    static func getInfo() -> [InfoUser]? {
        let infoUser = [
            InfoUser(id: "", name: "", description: "", height: 1.75, statusLife: "")
        ]
        return infoUser
    }
}
