//
//  AlbumsNew.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 08.10.2022.
//

import Foundation

struct FirstAlbum {
    var author: String
    var image: String
    var track: String
    
    // MARK: Создаём массив с помощью функции
    static func massiveAlbum() -> [FirstAlbum] {
        var post = [FirstAlbum]()
        post.append(FirstAlbum(author: "Saint JHN", image: "While The World Was Burning", track: "Back On The Ledge"))
        post.append(FirstAlbum(author: "Saint JHN", image: "While The World Was Burning", track: "Monica Lewinsky Election Year"))
        return post
    }
}

struct SecondAlbum {
    var author: String
    var image: String
    var track: String
    
    // MARK: Создаём массив с помощью функции
    static func massiveAlbum() -> [SecondAlbum] {
        var post = [SecondAlbum]()
        post.append(SecondAlbum(author: "Saint JHN", image: "Ghetto Lenny's Love Songs", track: "I Can Fvcking Tell"))
        post.append(SecondAlbum(author: "Saint JHN", image: "Ghetto Lenny's Love Songs", track: "Cult4Ever"))
        return post
    }
}
