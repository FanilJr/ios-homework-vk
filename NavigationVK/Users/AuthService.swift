//
//  AuthService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation

protocol AuthService {
    func login(email: String, password: String, completion: @escaping Handler)
    func createUser(email: String, password: String, completion: @escaping Handler)
    func signIn(email: String, password: String, completion: @escaping Handler)
    func signOut()
}
