//
//  CurrentUserService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation
import UIKit

final class CurrentUserService: UserService {
    
    let user = User(name: "ethic91@icloud.com", avatar: UIImage(named: "1")!, status: "Ты на один день ближе к своей мечте")
    
    func getUser(userName: String, completion: (Result<User, UserGetError>) -> Void) {
            if user.name == userName {
                completion(.success(user))
            } else {
                let debugUuser = User(name: userName, avatar: UIImage(systemName: "person.crop.circle.badge.questionmark.fill")!, status: "Проверка работы")
                completion(.success(debugUuser))
            }
        }

    }
