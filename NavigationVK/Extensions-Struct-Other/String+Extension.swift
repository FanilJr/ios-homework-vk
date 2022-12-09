//
//  String+Extension.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 28.10.2022.
//

import Foundation
import UIKit

extension String {
    var encodeURL: String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl: String
    {
    return self.removingPercentEncoding!
    }
}
