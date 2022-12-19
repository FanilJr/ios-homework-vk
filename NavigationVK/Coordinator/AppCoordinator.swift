//
//  AppCoordinator.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
import UIKit
//import FirebaseAuth

final class AppCoordinator: BaseCoordinator, Coordinator {
    private let viewControllerFactory: ViewControllersFactoryProtocol
    private let tabBarController = MainTabBarController()
    private var window: UIWindow?
    private let scene: UIWindowScene
    
    private enum Constants {
        static let newsImageName: String = "newspaper.circle"
        static let profileImageName: String = "person.circle"
        static let postFavoritesImageName: String = "heart.circle"
        static let playerImageName: String = "play.circle"
    }
    
    private enum ConstantsSelect {
        static let newsImageName: String = "newspaper.circle.fill"
        static let profileImageName: String = "person.circle.fill"
        static let postFavoritesImageName: String = "heart.circle.fill"
        static let playerImageName: String = "play.circle.fill"
    }

    init(scene: UIWindowScene, viewControllerFactory: ViewControllersFactoryProtocol) {
        self.scene = scene
        self.viewControllerFactory = viewControllerFactory
        super.init()
    }

    func start() {
        initWindow()
        initTabBarController()
    }

    private func initWindow() {
        let window = UIWindow(windowScene: scene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func initTabBarController() {
        tabBarController.viewControllers = settingsViewControllers()
    }
    
    private func settingsViewControllers() -> [UIViewController] {
        
        let ud = UserDefaults.standard
        
        //MARK: NEWS
        let newsVc = viewControllerFactory.viewController(for: .news)
        let navNewsVC = createNavController(for: newsVc, title: String("news.title").localized, image: UIImage(systemName: Constants.newsImageName)!, selectImage: UIImage(systemName: ConstantsSelect.newsImageName)!)
        let newsCoordinator = NewsCoordinator(navigationController: navNewsVC, viewControllerFactory: viewControllerFactory)
        
        //MARK: FAFORITES
        let postFavoritesVc = viewControllerFactory.viewController(for: .postFavorites)
        let navPostFavoritesVc = createNavController(for: postFavoritesVc, title: String("favorites.title").localized, image: UIImage(systemName: Constants.postFavoritesImageName)!, selectImage: (UIImage(systemName: ConstantsSelect.postFavoritesImageName) ?? UIImage()))
        let postFavoritesCoordinator = PostFavoritesCoordinator(navigationController: navPostFavoritesVc, viewControllerFactory: viewControllerFactory)
        
        //MARK: PLAYER
        let playerVC = viewControllerFactory.viewController(for: .player)
        let navPlayerVC = createNavController(for: playerVC, title: String("music.title").localized, image: UIImage(systemName: Constants.playerImageName)!, selectImage: (UIImage(systemName: ConstantsSelect.playerImageName) ?? UIImage()))
        let playerCoordinator = PlayerCoordinator(navigationController: navPlayerVC, viewControllerFactory: viewControllerFactory
        )

        addDependency(postFavoritesCoordinator)
        addDependency(newsCoordinator)
        addDependency(playerCoordinator)


        postFavoritesCoordinator.start()
        newsCoordinator.start()
        playerCoordinator.start()
        
        guard let userInfo = ud.object(forKey: "login_user") as? [String: String],
              let email = userInfo["email"]
        else {
            let loginViewModel = LoginViewModel()
            let logInVc = viewControllerFactory.viewController(for: .login(viewModel: loginViewModel))
            let navLogInVc = createNavController(
                for: logInVc,
                title: String("Авторизация").localized,
                image: UIImage(systemName: Constants.profileImageName)!, selectImage: (UIImage(systemName: ConstantsSelect.profileImageName) ?? UIImage()
            ))
            let logInCoordinator = LogInCoordinator(navigationController: navLogInVc, viewControllerFactory: viewControllerFactory)
            addDependency(logInCoordinator)
            logInCoordinator.start()
            
            return [navLogInVc, navPostFavoritesVc, navNewsVC, navPlayerVC]
        }
        
        let profileViewModel = ProfileViewModel()
        let testService = TestUserService()
        testService.user.fullName = email
        let profileVc = viewControllerFactory.viewController(for: .profile(viewModel: profileViewModel, service: testService, name: email)) as! ProfileViewController
        let navProfileInVc = createNavController(
            for: profileVc,
            title: String("profile.title").localized,
            image: UIImage(systemName: Constants.profileImageName)!, selectImage: (UIImage(systemName: ConstantsSelect.profileImageName) ?? UIImage()))
        let profileCoordinator = ProfileCoordinator(navigationController: navProfileInVc, fullName: email, service: testService, viewControllerFactory: viewControllerFactory)
        
        addDependency(profileCoordinator)
        profileCoordinator.start()
//        postFavoritesCoordinator.start()
    
        return [navProfileInVc, navPostFavoritesVc, navNewsVC, navPlayerVC]
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage, selectImage: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectImage
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        
        return navController
    }
}
