//
//  MainTabBarController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    let loginFactory: MyLoginFactory

    init(loginFactory: MyLoginFactory) {
        self.loginFactory = loginFactory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        createTabBarController()
        setupTabBar()
    }

    func setupTabBar() {

        let feedViewController = createNavController(vc: FeedViewController(), itemName: "Лента", itemImage: "doc.richtext")
        feedViewController.title = "Лента"
        let logInVC = LogInViewController()
        logInVC.delegate = loginFactory.makeLoginInspector()
        let profileViewController = createNavController(vc: logInVC, itemName: "Профиль", itemImage: "person.circle")
        viewControllers = [feedViewController, profileViewController]
    }

    func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {

        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage), tag: 0)
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item

        return navController
    }
    
//    func createTabBarController() -> UITabBarController {
//
//
//        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = [createFeedViewController(), createLoginViewController()]
//
//        return tabBarController
//
//    }
//
//    func createLoginViewController() -> UINavigationController {
//
//        let loginViewController = LogInViewController()
//        loginViewController.delegate = loginFactory.makeLoginInspector()
//        loginViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
//
//            return UINavigationController(rootViewController: loginViewController)
//    }
//
//    func createFeedViewController() -> UINavigationController {
//
//        let feedViewController = FeedViewController()
//        feedViewController.title = "Лента"
//        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "doc.richtext"), tag: 0)
//
//        return UINavigationController(rootViewController: feedViewController)
//    }
//}
}
