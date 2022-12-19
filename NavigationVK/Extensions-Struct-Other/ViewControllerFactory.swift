//
//  ViewControllerFactory.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
import UIKit

//enum TypeOfViewController {
//    case home
//    case news
//    case login(viewModel: LoginViewModel)
//    case profile(viewModel: ProfileViewModel, service: UserService, name: String)
//    case postView(title: String)
//    case infoView
//    case photosView
//    case postFavorites()
//    case registration(viewModel: RegistrationViewModel)
//}
//
//extension TypeOfViewController {
//    func makeViewController() -> UIViewController {
//        switch self {
//        case .home:
//            return HomeViewController()
//        case .feed(let viewModel):
//            return FeedViewController(viewModel: viewModel)
//        case .login(let viewModel):
//            return LogInViewController(viewModel: viewModel)
//        case .profile(let viewModel, let service, let name):
//            return ProfileViewController(viewModel: viewModel, service: service, fullName: name)
//        case .postView(let title):
//            return PostViewController(postTitle: title)
//        case .infoView:
//            return InfoViewController()
//        case .photosView:
//            return PhotosViewController()
//        case .audio(let viewModel):
//            return AudiosViewController(viewModel: viewModel)
//        case .record:
//            return RecordViewController()
//        case .postFavorites(let viewModel):
//            return PostFavoritesViewController(viewModel: viewModel)
//        case .map:
//            return MapViewController()
//        case .registration(let viewModel):
//            return RegistrationViewController(viewModel: viewModel)
//        }
//    }
//}
//
//protocol ViewControllerFactoryProtocol {
//    func viewController(for typeOfVc: TypeOfViewController) -> UIViewController
//}
//
//final class ViewControllerFactory: ViewControllerFactoryProtocol  {
//    func viewController(for typeOfVc: TypeOfViewController) -> UIViewController {
//        return typeOfVc.makeViewController()
//    }
//}
