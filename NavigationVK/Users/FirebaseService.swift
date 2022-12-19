//
//  FirebaseService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
import FirebaseAuth


final class FirebaseService: AuthService {
    private let auth = Auth.auth()
    private let ud = UserDefaults.standard
    
    func login(email: String, password: String, completion: @escaping Handler) {
        signIn(email: email, password: password, completion: completion)
        let userInfo = ["email": email, "password": password]
        ud.set(userInfo, forKey: "login_user")
    }
    
    func createUser(email: String, password: String, completion: @escaping Handler) {
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("\(String(describing: email)) created"))
                self?.signIn(email: email, password: password, completion: completion)
                let userInfo = ["email": email, "password": password]
                self?.ud.set(userInfo, forKey: "login_user")
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping Handler) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error,  let _ = AuthErrorCode(AuthErrorCode.Code(rawValue: error._code)!) {
                completion(.failure(error))
            } else {
                completion(.success("Login was \(String(describing: authResult?.user.email))"))
            }
        }
    }
    
    func signOut() {
        do {
            ud.removeObject(forKey: "login_user")
            print("Delete user from UserDefaults")
            try auth.signOut()
            print("Successfull logout!")
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
}

enum FirebaseServiceError: Error {
    case notFoundUser
    case userExist
}

extension FirebaseServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFoundUser:
            return "Не найден пользователь, необходимо зарегистрировать"
        case .userExist:
            return "Пользователь существует!"
        }
    }
}
