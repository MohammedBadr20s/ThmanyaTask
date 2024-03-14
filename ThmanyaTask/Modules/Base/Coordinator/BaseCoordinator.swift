//
//  BaseCoordinator.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import UIKit

class BaseCoordinator: Coordinator {
    var childCoordinalors: [Coordinator] = []
    var navigationController: UINavigationController
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(backDelegate: BackDelegate?) -> UINavigationController {
        return navigationController
    }
    
    
    func navigate(window: UIWindow?) {
        self.navigationController = UINavigationController()
        self.navigationController.isNavigationBarHidden = true
        let coordinator = UsersCoordinator(navigationController: self.navigationController)
        self.childCoordinalors.append(coordinator)
        coordinator.start(backDelegate: nil)
        window?.rootViewController?.removeFromParent()
        window?.rootViewController = self.navigationController
        window?.makeKeyAndVisible()
    }


}
