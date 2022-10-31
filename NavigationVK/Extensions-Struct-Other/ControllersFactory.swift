//
//  ControllersFactory.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 01.09.2022.
//

import Foundation

final class ControllersFactory {

    let loginFactory = MyLoginFactory()
    var userService: UserService {
        #if DEBUG
            return CurrentUserService()
        #else
            return TestUserService()
        #endif
    }

    func makeFeedViewController(coordinator: FeedFlowCoordinator) -> FeedViewController {
        let feedVC = FeedViewController(model: FeedModel(), coordinator: coordinator)
        return feedVC
    }

    func makeLoginViewController(coordinator: ProfileFlowCoordinator) -> LogInViewController {
        let viewModel = LoginViewModel(loginFactory: loginFactory, coordinator: coordinator)
        let logInVC = LogInViewController(viewModel: viewModel)
        return logInVC
    }

    func makeProfileViewController(userName: String, coordinator: ProfileFlowCoordinator) -> ProfileViewController {
        let viewModel = ProfileViewModel()
        let profileVC = ProfileViewController(userService: userService, userName: userName, viewModel: viewModel, coordinator: coordinator)
        return profileVC
    }
    
    func makeFavoriteViewController(coordinator: FavoriteFlowCoordinator) -> FavoriteViewController {
        let viewModel = CoreDataManager()
        let favoriteVC = FavoriteViewController(model: viewModel, coordinator: coordinator)
        return favoriteVC
    }
    
    func makeNewsViewController(coordinator: NewsFlowCoordinator) -> NewsListController {
        let favoriteVC = NewsListController()
        return favoriteVC
    }
    
    func makePlayerViewController(coordinator: PlayerFlowCoordinator) -> PlayerViewController {
        let playerVC = PlayerViewController()
        return playerVC
    }
    
}
