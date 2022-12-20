//
//  RegistrationCoordinator.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
import UIKit

final class RegistrationCoordinator: Coordinator {
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllersFactoryProtocol
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllersFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let viewModel = RegistrationViewModel()
        let viewController = viewControllerFactory.viewController(for: .registration(viewModel: viewModel)) as! RegistratonViewController
        viewModel.showMainVc = showProfileVc(email:password:)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showProfileVc(email: String, password: String) {
        var currentUser: UserService
        let fullName = email
        
        #if DEBUG
            currentUser = TestUserService()
        #else
           let user = User(
            fullName: fullName,
            avatar: "1",
            status: "Waiting for something..."
           )
           currentUser = CurrentService(user: user)
        #endif
        let profileCoordinator = ProfileCoordinator(
            navigationController: navigationController!,
            fullName: fullName,
            service: currentUser,
            viewControllerFactory: viewControllerFactory
        )
        profileCoordinator.start()
    }
}
