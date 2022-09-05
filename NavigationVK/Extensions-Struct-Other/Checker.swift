//
//  Checker.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation

class Checker {
    
    static let shared = Checker()
    
    private let login = "Fanil_Jr"
    private let password = "Netology"
    
    private init() {}
    
    func authorization(login: String, password: String) -> Bool {
        return self.login.hash == login.hash && self.password.hash == password.hash
    }
}
