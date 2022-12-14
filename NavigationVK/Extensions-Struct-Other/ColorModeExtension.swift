//
//  ColorModeExtension.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 08.12.2022.
//

import Foundation
import UIKit

public extension UIColor {
    static func createColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor { ( traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? dark : light }
    }
}