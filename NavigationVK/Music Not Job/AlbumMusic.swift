//
//  AlbumMusic.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 05.10.2022.
//

import Foundation

class AlbumMusic: CustomStringConvertible {

    let filenameFor1400image: String
    
    let title: String
    let year: String
    let filenameBase: String
    let tracks: [String]
    var totalTracks: Int {
        return tracks.count
    }
    var description: String {
        return "(\(year)) \(title)"
    }
    
    required init( title: String, year: String, filenameBase: String ) {
        self.title = title
        self.year = year
        self.tracks = AlbumMusic.fetchTracks( albumTitle: title )
        self.filenameBase = filenameBase
        self.filenameFor1400image = "Ghetto Lenny's Love Songs"
    }
    
    
    class func fetchTracks( albumTitle: String ) -> [String] {
    
        let GhettoLenny = [
            "94 Bentley",
            "All I Want is A Yacht",
            "Anything Can Happen"
        ]
    
        let WhileTheWorldWasBurning = [
            "Back On The Ledge",
            "Freedom Is Priceless"
        ]
        // album titles : tracks names
        let allTracks = [
            "Ghetto Lenny's Love Songs" : GhettoLenny,
            "The Bird's Heart": WhileTheWorldWasBurning,
        ]
    
        return allTracks[albumTitle]!
    }
}
