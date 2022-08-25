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

        setupTabBar()
    }

    func setupTabBar() {

        let feedViewController = createNavController(vc: FeedViewController(), itemName: "Лента", itemImage: "doc.richtext")
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

}
