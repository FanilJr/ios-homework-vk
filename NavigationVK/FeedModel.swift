//
//  FeedModel.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 29.08.2022.
//

import Foundation

class FeedModel {

    let password = "junior"
    
    var isValidWord = false {
        didSet {
            NotificationCenter.default.post(name: .updateIsValidWord, object: isValidWord)
        }
    }

    func check(word: String) {
        
        if password == word {
            isValidWord = true
        } else {
            isValidWord = false
        }
    }
}
