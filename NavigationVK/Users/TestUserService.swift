//
//  TestUserService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation
import UIKit

class TestUserService: UserService {
    var user: User = User(fullName: "Fanil_Jr", avatar: "myAvatar2", status: "Разработчик 👨🏽‍💻")

    func getUser(fullName: String) throws -> User {
        return user
    }
}

