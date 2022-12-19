//
//  SceneDelegate.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 20.08.2022.
//

import UIKit
import AVFoundation
import FirebaseCore
import FirebaseAuth
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let loginFactory = MyLoginFactory()
    private var appCoordinator: AppCoordinator?
    private var viewControllerFactory: ViewControllersFactoryProtocol!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        FirebaseApp.configure()
            
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            let blureEffect = UIBlurEffect(style: .light)
            appearance.backgroundEffect = blureEffect

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().backgroundColor = .clear
            UITabBar.appearance().tintColor = #colorLiteral(red: 0.9294139743, green: 0.2863991261, blue: 0.3659052849, alpha: 1)
            UITabBar.appearance().unselectedItemTintColor = UIColor.createColor(light: .black, dark: .white)
        }

//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(windowScene: windowScene)
//        let mainCoordinator: MainCoordinator = MainCoordinatorImp()
//        let user = FirebaseAuth.Auth.auth().currentUser
//        window?.rootViewController = mainCoordinator.startApplication(userEmail: user?.email)
        
//        guard let element = AppConfiguration.allCases.randomElement() else { return }
//        NetworkService.makeRequest(urlString: element.rawValue)

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        viewControllerFactory = ViewControllerFactory()
        
        appCoordinator = AppCoordinator(scene: windowScene, viewControllerFactory: viewControllerFactory)
        appCoordinator?.start()

//        let navigationVC = UINavigationController()
//        let controllersFactory = ControllersFactory()
//        let profileChildCoordinator = ProfileFlowCoordinator(navCon: navigationVC, controllersFactory: controllersFactory)
//        let logInVC = controllersFactory.makeLoginViewController(coordinator: profileChildCoordinator)
//        window?.rootViewController = logInVC
//        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
//        self.saveContext()
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}
