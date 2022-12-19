//
//  LoginService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation

enum LoginService {
    case firebase
//    case realm
    
    var current: AuthService {
        switch self {
        case .firebase:
            return FirebaseService()
//        case .realm:
//            return RealmService()
        }
    }
}
