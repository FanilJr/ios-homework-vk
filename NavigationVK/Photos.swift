//
//  Photos.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import Foundation
import UIKit

var galery: [UIImage] {
    
    var galeryPhoto = [UIImage]()
    
    for i in 1...7 {
        
        galeryPhoto.append(UIImage(named: "P\(i)")!)
    }
    return galeryPhoto
    
}
