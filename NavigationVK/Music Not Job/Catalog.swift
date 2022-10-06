//
//  Catalog.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 05.10.2022.
//

import Foundation

class Catalog {
    
    let albums: [AlbumMusic]
    var totalAlbums: Int {
        return albums.count
    }
    
    required init() {
        self.albums = Catalog.fetchAlbums()
    }
    
    class func fetchAlbums() -> [AlbumMusic] {
        let ghettoLenny = AlbumMusic( title: "Ghetto Lenny's Love Songs", year: "2016", filenameBase: "GhettoLenny" )
        let WhieTheWorld = AlbumMusic( title: "The Bird's Heart", year: "2015", filenameBase: "WhileTheWorldWasBurning" )
        
        return [ghettoLenny, WhieTheWorld]
    }
}
