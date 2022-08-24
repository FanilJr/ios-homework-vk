//
//  User.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation
import UIKit

final class User {
    
    var name: String
    var avatar: UIImage
    var status: String
    
    init(name: String, avatar: UIImage, status: String) {
        self.name = name
        self.avatar = avatar
        self.status = status
    }
    
}
