//
//  ProfileTests.swift
//  NavigationVKTests
//
//  Created by Fanil_Jr on 19.12.2022.
//

import XCTest

//@testable import NavigationVK

class ProfileTests: XCTestCase {
    var navigationController: UINavigationController!
    var viewControllerFactory: ViewControllersFactoryProtocol!
    var profileCoordinator: ProfileCoordinatorMock!
    var profileCoordinatorFlow: ProfileCoordinatorFlowMock!

    override func setUpWithError() throws {
        navigationController = UINavigationController()
        viewControllerFactory = ViewControllerFactory()
        profileCoordinator = ProfileCoordinatorMock(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
        profileCoordinatorFlow = ProfileCoordinatorFlowMock(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
    }

    override func tearDownWithError() throws {
        navigationController = nil
        viewControllerFactory = nil
        profileCoordinator = nil
        profileCoordinatorFlow = nil
    }

    func testShowPhotosVc() throws {
        profileCoordinator.start()
        profileCoordinatorFlow.showPhotosVc()
        
        XCTAssertEqual(profileCoordinatorFlow.expectedShowPhotosVc, 1)
    }
    
    func testShowLoginVc() throws {
        profileCoordinator.start()
        profileCoordinatorFlow.showLoginVc()
        
        XCTAssertEqual(profileCoordinatorFlow.expectedShowLoginVc, 1)
    }

}

final class ProfileCoordinatorFlowMock: ProfileCoordinatorFlowProtocol {
    
    var navigationController: UINavigationController
    var viewControllerFactory: ViewControllersFactoryProtocol
    
    required init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllersFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    var expectedShowPhotosVc = 0
    
    func showPhotosVc() {
        expectedShowPhotosVc += 1
        print(expectedShowPhotosVc)
    }
    
    var expectedShowLoginVc = 0

    func showLoginVc() {
        expectedShowLoginVc += 1
    }
    
    var expectedShowImageSettingsVc = 0
    
    func showImageSettings() {
        expectedShowImageSettingsVc += 1
    }
}

final class ProfileCoordinatorMock: ProfileCoordinator {
    let navigationController: UINavigationController
    let viewControllerFactory: ViewControllersFactoryProtocol
    
    init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllersFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
        super.init(
            navigationController: navigationController,
            fullName: "Test",
            service: TestUserService(),
            viewControllerFactory: viewControllerFactory
        )
    }
}

