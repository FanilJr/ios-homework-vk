//
//  SplashPresenter.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 03.09.2022.
//

import Foundation
import UIKit

protocol SplashPresenterDescription {
    func present()
    func dismiss(complition: (() -> Void)?)
}
//
//final class SplashPresenter: SplashPresenterDescription {
//
//    private lazy var forgroundSplashWindow: UIWindow = {
//        let splashWindow = UIWindow()
//
//        let splashView = SplashViewController()
//
//        splashWindow.windowLevel = .normal + 1
//        splashWindow.rootViewController = splashView
//
//        return splashWindow
//    }()
//
//    func present() {
//        forgroundSplashWindow.isHidden = false
//
//        let splashViewController = forgroundSplashWindow.rootViewController as? SplashViewController
//
//        UIView.animate(withDuration: 0.3) {
//            splashViewController?.vkLogo.transform = CGAffineTransform(scaleX: 88 / 72, y: 88 / 72)
//        }
//    }
//
//    func dismiss(complition: (() -> Void)?) {
//        UIView.animate(withDuration: 0.3) {
//            self.forgroundSplashWindow.alpha = 0
//        } completion: { (_) in
//            complition?()
//        }
//    }
//}
