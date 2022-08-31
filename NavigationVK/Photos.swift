//
//  Photos.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//
//
import Foundation
import UIKit

public var galery: [UIImage]  {
    
    get {
        var galeryPhoto = [UIImage]()
        
        for i in 1...15 {
            
            galeryPhoto.append(UIImage(named: "P\(i)")!)
        }
        return galeryPhoto
    }
    set {}
}
