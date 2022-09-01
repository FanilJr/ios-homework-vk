//
//  MainCoordinator.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 01.09.2022.
//

import Foundation
import UIKit

enum TabBarPage {
    case feed
    case profile

    var pageTitle: String {
        switch self {
        case .feed:
            return "Лента"
        case .profile:
            return "Профиль"
        }
    }

    var image: UIImage? {
        switch self {
        case .feed:
            return UIImage(systemName: "doc.richtext")
        case .profile:
            return UIImage(systemName: "person.crop.circle")
        }
    }
}

protocol MainCoordinator {
    func startApplication() -> UIViewController
}

final class MainCoordinatorImp: MainCoordinator {

    private let controllersFactory = ControllersFactory()


    // проверка авторизован ли юзер
    // показать либо экран авторизации, либо новостную ленту
    func startApplication() -> UIViewController {
        return getTabBarController()
    }

    //MARK: - Metods
    private func getTabBarController() -> UIViewController {
        let tabBarVC = MainTabBarController()
        let pages: [TabBarPage] = [.feed, .profile]

        tabBarVC.setViewControllers(pages.map { getNavController(page: $0) }, animated: true)
        return tabBarVC
    }

      private func getNavController(page: TabBarPage) -> UINavigationController {
          let navigationVC = UINavigationController()
          navigationVC.tabBarItem.image = page.image
          navigationVC.tabBarItem.title = page.pageTitle

          switch page {
          case .feed:
              let feedChildCoordinator = FeedFlowCoordinator(navCon: navigationVC, controllersFactory: controllersFactory)
              let feedVC = controllersFactory.makeFeedViewController(coordinator: feedChildCoordinator)
              navigationVC.pushViewController(feedVC, animated: true)
          case .profile:
              let profileChildCoordinator = ProfileFlowCoordinator(navCon: navigationVC, controllersFactory: controllersFactory)
              let logInVC = controllersFactory.makeLoginViewController(coordinator: profileChildCoordinator)
              navigationVC.pushViewController(logInVC, animated: true)
          }

          return navigationVC
      }
}
