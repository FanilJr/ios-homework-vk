//
//  LoginCoordinator.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
import UIKit

protocol LogInCoordinatorFlowProtocol {
    var navigationController: UINavigationController { get }
    var viewControllerFactory: ViewControllersFactoryProtocol { get }
    
    func showProfileVc(fullName: String)
}

class LogInCoordinatorFlow: LogInCoordinatorFlowProtocol {
    let navigationController: UINavigationController
    let viewControllerFactory: ViewControllersFactoryProtocol
    
    init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllersFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func showProfileVc(fullName: String) {
        var currentUser: UserService
        
//        #if DEBUG
//            currentUser = TestUserService()
//        #else
           let user = User(
            fullName: fullName,
            avatar: "1",
            status: "Разработчик 👨🏽‍💻"
           )
           currentUser = CurrentService(user: user)
        
//        #endif
        let profileCoordinator = ProfileCoordinator(
            navigationController: navigationController,
            fullName: fullName,
            service: currentUser,
            viewControllerFactory: viewControllerFactory
        )
        profileCoordinator.start()
    }
    
    func showRegistrationVc() {
        let registrationCoordinator = RegistrationCoordinator(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
        registrationCoordinator.start()
    }
}

class LogInCoordinator: Coordinator {
    private let myLoginFactory = MyLoginFactory()
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllersFactoryProtocol
    private let logInCoordinatorFlow: LogInCoordinatorFlow
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllersFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
        self.logInCoordinatorFlow = LogInCoordinatorFlow(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
    }
    
    func start() {
        let viewModel = LoginViewModel()
        let viewController = viewControllerFactory.viewController(for: .login(viewModel: viewModel)) as! LogInViewController
        viewController.delegate = myLoginFactory.makeLoginInspector()
        viewModel.showProfileVc = logInCoordinatorFlow.showProfileVc(fullName:)
        viewModel.showRegistrationVc = logInCoordinatorFlow.showRegistrationVc
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
