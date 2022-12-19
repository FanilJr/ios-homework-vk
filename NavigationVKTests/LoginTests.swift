//
//  LoginTests.swift
//  NavigationVKTests
//
//  Created by Fanil_Jr on 19.12.2022.
//

import XCTest
import UIKit
//@testable import NavigationVK

class LoginTests: XCTestCase {
    var navigationController: UINavigationController!
    var viewControllerFactory: ViewControllersFactoryProtocol!
    var loginCoordinator: LogInCoordinatorMock!
    var loginCoordinatorFlow: LogInCoordinatorFlowMock!


    override func setUpWithError() throws {
        try super.setUpWithError()
        
        navigationController = UINavigationController()
        viewControllerFactory = ViewControllerFactory()
        loginCoordinator = LogInCoordinatorMock(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
        loginCoordinatorFlow = LogInCoordinatorFlowMock(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory
        )
    }

    override func tearDownWithError() throws {
        viewControllerFactory = nil
        navigationController = nil
        loginCoordinator = nil
        loginCoordinatorFlow = nil
        
        try super.tearDownWithError()
    }

    func testLogin() throws {
        loginCoordinator.start()
        loginCoordinatorFlow.showProfileVc(fullName: "Test")
        XCTAssertEqual(loginCoordinatorFlow.showProfileVcCalls, 1)
        XCTAssertEqual(loginCoordinatorFlow.expectedName, "Test")
    }
}

final class LogInCoordinatorFlowMock: LogInCoordinatorFlowProtocol {
    let navigationController: UINavigationController
    let viewControllerFactory: ViewControllersFactoryProtocol
    
    required init(
        navigationController: UINavigationController,
        viewControllerFactory: ViewControllersFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    var showProfileVcCalls: Int = 0
    var expectedName: String = ""
    func showProfileVc(fullName: String) {
        showProfileVcCalls += 1
        expectedName = fullName
    }
}

final class LogInCoordinatorMock: LogInCoordinator {}
