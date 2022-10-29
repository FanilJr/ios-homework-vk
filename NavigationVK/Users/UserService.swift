//
//  UserService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation

enum UserGetError: Error {
    case notFound
    case unowned
}

protocol UserService {
    func getUser(userName: String, completion: (Result<User,UserGetError>) -> Void)
}
