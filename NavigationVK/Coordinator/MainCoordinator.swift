//
//  MainCoordinator.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 01.09.2022.
//

import Foundation
import UIKit

enum TabBarPage {
//    case feed
    case news
    case profile
    case favorite
    case player

    var pageTitle: String {
        switch self {
//        case .feed:
//            return "Лента"
        case .news:
            return "news.title".localized
        case .profile:
            return "profile.title".localized
        case .favorite:
            return "favorites.title".localized
        case .player:
            return "music.title".localized

        }
    }

    var image: UIImage? {
        switch self {
//        case .feed:
//            return UIImage(systemName: "rectangle.badge.person.crop")
        case .news:
            return UIImage(systemName: "newspaper.circle")
        case .profile:
            return UIImage(systemName: "person.circle")
        case .favorite:
            return UIImage(systemName: "heart.circle")
        case .player:
            return UIImage(systemName: "play.circle")
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
//        case .feed:
//            return UIImage(systemName: "rectangle.fill.badge.person.crop")
        case .news:
            return UIImage(systemName: "newspaper.circle.fill")
        case .profile:
            return UIImage(systemName: "person.circle.fill")
        case .favorite:
            return UIImage(systemName: "heart.circle.fill")
        case .player:
            return UIImage(systemName: "play.circle.fill")
        }
    }
}

protocol MainCoordinator {
    func startApplication(userEmail: String?) -> UIViewController
}

final class MainCoordinatorImp: MainCoordinator {

    private let controllersFactory = ControllersFactory()
    private var userEmail: String?

    // проверка авторизован ли юзер
    // показать либо экран авторизации, либо новостную ленту
    func startApplication(userEmail: String?) -> UIViewController {
        self.userEmail = userEmail
        return getTabBarController()
    }

    //MARK: - Metods
    private func getTabBarController() -> UIViewController {
        let tabBarVC = MainTabBarController()
        let pages: [TabBarPage] = [.news, .profile, .favorite, .player]
        tabBarVC.setViewControllers(pages.map { getNavController(page: $0) }, animated: true)
        return tabBarVC
    }

      private func getNavController(page: TabBarPage) -> UINavigationController {
          let navigationVC = UINavigationController()
          navigationVC.tabBarItem.image = page.image
          navigationVC.tabBarItem.selectedImage = page.selectedImage
          navigationVC.tabBarItem.title = page.pageTitle
          
          switch page {
//          case .feed:
//              let feedChildCoordinator = FeedFlowCoordinator(navCon: navigationVC, controllersFactory: controllersFactory)
//              let feedVC = controllersFactory.makeFeedViewController(coordinator: feedChildCoordinator)
//              navigationVC.pushViewController(feedVC, animated: true)
          case .news:
              let newsChildCoordinator = NewsFlowCoordinator(navCon: navigationVC, controllersFactory: controllersFactory)
              let newsVC = controllersFactory.makeNewsViewController(coordinator: newsChildCoordinator)
              navigationVC.pushViewController(newsVC, animated: true)
              
          case .profile:
              let profileChildCoordinator = ProfileFlowCoordinator(navCon: navigationVC, controllersFactory: controllersFactory)
              let logInVC = controllersFactory.makeLoginViewController(coordinator: profileChildCoordinator)
              navigationVC.pushViewController(logInVC, animated: true)
              //открываем экран профиля, если пользователь авторизован
              if let userEmail = userEmail {
                  let profileVC =  controllersFactory.makeProfileViewController(
                    userName: userEmail,
                    coordinator: profileChildCoordinator
                  )
                  navigationVC.pushViewController(profileVC, animated: true)
              }
              
          case .favorite:
              let favoriteChildCoordinator = FavoriteFlowCoordinator(navCon: navigationVC, controllersFactory: controllersFactory)
              let favoriteVC = controllersFactory.makeFavoriteViewController(coordinator: favoriteChildCoordinator)
              navigationVC.pushViewController(favoriteVC, animated: true)
              
          case .player:
              let playerChildCoordinator = PlayerFlowCoordinator(navCon: navigationVC, controllersFactory: controllersFactory)
              let playerVC = controllersFactory.makePlayerViewController(coordinator: playerChildCoordinator)
              navigationVC.pushViewController(playerVC, animated: true)
          }
          return navigationVC
      }
}

