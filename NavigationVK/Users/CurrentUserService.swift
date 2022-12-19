//
//  CurrentUserService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation

enum UserNotFoundError: Error {
    case userNotFound
}

extension UserNotFoundError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "Пользователь не найден"
        }
    }
}

class CurrentService: UserService {
    var user: User
    
    init(user: User) {
        self.user = user
    }

    func getUser(fullName: String) throws -> User {
        guard user.fullName == fullName else { throw UserNotFoundError.userNotFound }
        return user
    }
    
}
