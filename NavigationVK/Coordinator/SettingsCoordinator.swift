//
//  SettingsCoordinator.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 18.12.2022.
//

import Foundation
import UIKit

final class SettingsCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllersFactoryProtocol
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllersFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let settingsVc = viewControllerFactory.viewController(for: .settings) as! SettingsViewController
        navigationController?.present(settingsVc, animated: true)
    }
}
