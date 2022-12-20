//
//  ProfileCoordinator.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
import UIKit

protocol ProfileCoordinatorFlowProtocol {
    var navigationController: UINavigationController { get }
    var viewControllerFactory: ViewControllersFactoryProtocol { get }
    
    func showPhotosVc()
    func showLoginVc()
    func showPostVc(post: Post)
    func showImageSettings()
}

class ProfileCoordinatorFlow: ProfileCoordinatorFlowProtocol {
   
    let navigationController: UINavigationController
    let viewControllerFactory: ViewControllersFactoryProtocol
    
    private let myLoginFactory = MyLoginFactory()
    
    init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllersFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func showPhotosVc() {
        let photosViewCoordinator = PhotosViewCoordinator(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
        photosViewCoordinator.start()
    }
    
    func showLoginVc() {
        let loginInspector = myLoginFactory.makeLoginInspector()
        loginInspector.signOut()
        let logInCoordinator = LogInCoordinator(navigationController: navigationController,viewControllerFactory: viewControllerFactory)
        logInCoordinator.start()
    }
    
    func showPostVc(post: Post) {
        let postViewCoordinator = ProfilePostCoordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
        postViewCoordinator.start()
    }
    
    func showImageSettings() {
        let settingsViewCoordinator = SettingsCoordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
        settingsViewCoordinator.start()
    }
}

class ProfileCoordinator: Coordinator {
    let posts = [Post]()
    private weak var navigationController: UINavigationController?
    private let fullName: String
    private let service: UserService
    private let viewControllerFactory: ViewControllersFactoryProtocol
    private let profileCoordinatorFlow: ProfileCoordinatorFlow
    
    init(
        navigationController: UINavigationController,
        fullName: String, service: UserService,
        viewControllerFactory: ViewControllersFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.fullName = fullName
        self.service = service
        self.viewControllerFactory = viewControllerFactory
        self.profileCoordinatorFlow = ProfileCoordinatorFlow(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
    }
    
    func start() {
        let viewModel = ProfileViewModel()
        let profileVc = viewControllerFactory.viewController(
            for: .profile(
                viewModel: viewModel,
                service: service,
                name: fullName
            )
        ) as! ProfileViewController
        viewModel.showPhotosVc = profileCoordinatorFlow.showPhotosVc
        viewModel.showLoginVc = profileCoordinatorFlow.showLoginVc
        viewModel.showPostVc = profileCoordinatorFlow.showPostVc(post:)
        viewModel.showImageSettingsVc = profileCoordinatorFlow.showImageSettings
        navigationController?.setViewControllers([profileVc], animated: false)
    }
}

