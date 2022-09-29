//
//  Album.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 27.09.2022.
//

import Foundation

struct Album {
    var name: String
    var image: String
    var songs: [Song]
}

extension Album {
    static func get() -> [Album] {
        return [
        Album(name: "Shetto Lenny's Love Songs", image: "Album1", songs: [
            Song(name: "Trophies", image: "artist", artist: "SaintJHN", fileName: "Trophies"),
            Song(name: "Brilliant", image: "artist", artist: "SaintJHN", fileName: "Brilliant"),
            Song(name: "White", image: "artist", artist: "SaintJHN", fileName: "White")
        ]),
        Album(name: "While The World Was Burning", image: "Album2", songs: [
            Song(name: "For The Squadron", image: "artist", artist: "SaintJHN", fileName: "For The Squadron"),
            Song(name: "Roses", image: "artist", artist: "SaintJHN", fileName: "Roses"),
            Song(name: "Reflex", image: "artist", artist: "SaintJHN", fileName: "Reflex"),
            Song(name: "Sucks To Be You", image: "artist", artist: "SaintJHN", fileName: "Sucks To Be You")
        ])]
    }
}
