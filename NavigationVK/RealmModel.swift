//
//  RealmModel.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 25.10.2022.
//

import Foundation
import RealmSwift

class LoginModel: Object {
    
    @objc dynamic var login: String = ""
    @objc dynamic var password: String = ""
    
}
