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

        var galeryPhoto = [UIImage]()
        
        for i in 1...22 {
            galeryPhoto.append(UIImage(named: "P\(i)")!)
        }
        return galeryPhoto
}
