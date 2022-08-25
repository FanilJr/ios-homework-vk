//
//  UserService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation

protocol UserService {
    func getUser(userName: String) -> User?
}
