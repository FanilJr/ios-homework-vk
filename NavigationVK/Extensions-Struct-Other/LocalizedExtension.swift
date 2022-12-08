//
//  LocalizedExtension.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 08.12.2022.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
