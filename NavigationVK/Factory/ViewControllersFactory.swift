//
//  ViewControllerFactory.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
import UIKit

enum TypeOfViewController {
    case home
    case login(viewModel: LoginViewModel)
    case profile(viewModel: ProfileViewModel, service: UserService, name: String)
    case photosView
    case postFavorites
    case profilePost
    case news
    case player
    case registration(viewModel: RegistrationViewModel)
    case settings
}

extension TypeOfViewController {
    func makeViewController() -> UIViewController {
        switch self {
        case .home:
            return MainTabBarController()
        case .login(let viewModel):
            return LogInViewController(viewModel: viewModel)
        case .profile(let viewModel, let service, let name):
            return ProfileViewController(viewModel: viewModel, service: service, fullName: name)
        case .photosView:
            return PhotosViewController()
        case .postFavorites:
            return FavoriteViewController()
        case .profilePost:
            return ProfilePostViewController()
        case .news:
            return NewsListController()
        case .player:
            return  PlayerViewController()
        case .registration(let viewModel):
            return RegistratonViewController(viewModel: viewModel)
        case .settings:
            return SettingsViewController()
        }
    }
}

protocol ViewControllersFactoryProtocol {
    func viewController(for typeOfVc: TypeOfViewController) -> UIViewController
}

final class ViewControllerFactory: ViewControllersFactoryProtocol  {
    func viewController(for typeOfVc: TypeOfViewController) -> UIViewController {
        return typeOfVc.makeViewController()
    }
}
