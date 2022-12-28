//
//  Info.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 26.12.2022.
//

import Foundation

public struct InfoUser: Equatable {
    public let id: String
    public let name: String
    public let description: String
    public let height: Double
    public let statusLife: String
    
    public init(id: String, name: String, description: String, height: Double, statusLife: String) {
        self.id = id
        self.name = name
        self.description = description
        self.height = height
        self.statusLife = statusLife
    }
}
