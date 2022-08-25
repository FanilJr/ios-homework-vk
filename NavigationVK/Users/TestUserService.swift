//
//  TestUserService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation
import UIKit

final class TestUserService: UserService {
    
    let user = User(name: "Fanil_Jr", avatar: UIImage(named: "error")!, status: "Пробный статус")
    
    func getUser(userName: String) -> User? {
        user.name == userName ? user : nil
    }
}
