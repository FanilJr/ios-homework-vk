//
//  TestUserService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation
import UIKit

final class TestUserService: UserService {
    
    let user = User(name: "ethic91@icloud.com", avatar: UIImage(named: "error")!, status: "Пробный статус")
    
    func getUser(userName: String, completion: (Result<User, UserGetError>) -> Void) {
        if user.name == userName {
            completion(.success(user))
        } else {
            let debugUuser = User(name: userName, avatar: UIImage(systemName: "person.fill.questionmark")!, status: "Проверка работы Login сервиса")
            completion(.success(debugUuser))
        }
    }
}
