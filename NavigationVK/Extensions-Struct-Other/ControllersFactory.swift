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
        let profileVC = ProfileViewController(userService: userService, userName: userName, coordinator: coordinator)
        return profileVC
    }
}
