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
        Album(name: "Ghetto Lenny's Love Songs", image: "Ghetto Lenny's Love Songs", songs: [
            Song(name: "94 Bentley", image: "artist", artist: "SaintJHN", fileName: "94 Bentley"),
            Song(name: "All I Want is A Yacht", image: "artist", artist: "SaintJHN", fileName: "All I Want is A Yacht"),
            Song(name: "Anything Can Happen", image: "artist", artist: "SaintJHN", fileName: "Anything Can Happen"),
            Song(name: "Borders", image: "artist", artist: "SaintJHN", fileName: "Borders"),
            Song(name: "Call Me After You Hear This", image: "artist", artist: "SaintJHN", fileName: "Call Me After You Hear This"),
            Song(name: "Cult4Ever", image: "artist", artist: "SaintJHN", fileName: "Cult4Ever"),
            Song(name: "High School Reunion", image: "artist", artist: "SaintJHN", fileName: "High School Reunion"),
            Song(name: "I Can Fvcking Tell", image: "artist", artist: "SaintJHN", fileName: "I Can Fvcking Tell"),
            Song(name: "Monica Lewinsky", image: "artist", artist: "SaintJHN", fileName: "Monica Lewinsky"),
            Song(name: "Thousand", image: "artist", artist: "SaintJHN", fileName: "Thousand"),
            Song(name: "Wedding Day", image: "artist", artist: "SaintJHN", fileName: "Wedding Day"),
            Song(name: "Who Do You Blame", image: "artist", artist: "SaintJHN", fileName: "Who Do You Blame"),
            Song(name: "Trophies", image: "artist", artist: "SaintJHN", fileName: "Trophies")
        ]),
        Album(name: "While The World Was Burning", image: "While The World Was Burning", songs: [
            Song(name: "Back On The Ledge", image: "artist", artist: "SaintJHN", fileName: "Back On The Ledge"),
            Song(name: "Freedom Is Priceless", image: "artist", artist: "SaintJHN", fileName: "Freedom Is Priceless"),
            Song(name: "Gorgeous", image: "artist", artist: "SaintJHN", fileName: "Gorgeous"),
            Song(name: "High School Reunion Prom", image: "artist", artist: "SaintJHN", fileName: "High School Reunion Prom"),
            Song(name: "Monica Lewinsky Election Year", image: "artist", artist: "SaintJHN", fileName: "Monica Lewinsky Election Year"),
            Song(name: "Pray 4 Me", image: "artist", artist: "SaintJHN", fileName: "Pray 4 Me"),
            Song(name: "Quarantine Wifey", image: "artist", artist: "SaintJHN", fileName: "Quarantine Wifey"),
            Song(name: "Ransom", image: "artist", artist: "SaintJHN", fileName: "Ransom"),
            Song(name: "Roses Remix", image: "artist", artist: "SaintJHN", fileName: "Roses Remix"),
            Song(name: "Smack DVD", image: "artist", artist: "SaintJHN", fileName: "Smack DVD"),
            Song(name: "Sucks To Be You", image: "artist", artist: "SaintJHN", fileName: "Sucks To Be You"),
            Song(name: "Switching Sides", image: "artist", artist: "SaintJHN", fileName: "Switching Sides"),
            Song(name: "Time For Demons", image: "artist", artist: "SaintJHN", fileName: "Time For Demons"),
        ])]
    }
}
