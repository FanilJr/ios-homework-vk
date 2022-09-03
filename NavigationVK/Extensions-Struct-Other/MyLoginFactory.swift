//
//  MyLoginFactory.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation

class MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        
        return LoginInspector()
    }

}
