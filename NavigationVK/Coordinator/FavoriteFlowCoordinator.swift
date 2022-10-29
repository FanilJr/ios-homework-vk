//
//  FavoriteFlowCoordinator.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 27.10.2022.
//

import Foundation
import UIKit

final class FavoriteFlowCoordinator {
    
    private let controllersFactory: ControllersFactory
    let navCon: UINavigationController
    
    init(navCon: UINavigationController, controllersFactory: ControllersFactory) {
        self.controllersFactory = controllersFactory
        self.navCon = navCon
    }
}
