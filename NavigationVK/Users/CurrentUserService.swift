//
//  CurrentUserService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation
import UIKit

final class CurrentUserService: UserService {
    
    let user = User(name: "Fanil_Jr", avatar: UIImage(named: "1")!, status: "Ты на один день ближе к своей мечте")
    
    func getUser(userName: String) -> User? {
        user.name == userName ? user : nil
    }
}
