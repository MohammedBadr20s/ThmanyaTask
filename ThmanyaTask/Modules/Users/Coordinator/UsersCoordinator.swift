//
//  UsersCoordinator.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import UIKit

class UsersCoordinator: Coordinator {
    var childCoordinalors: [Coordinator] = []
    var navigationController: UINavigationController
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @discardableResult func start(backDelegate: BackDelegate?) -> UINavigationController {
        let viewModel = UsersViewModel(
            navigationDelegate: self,
            backDelegate: self)
        let vc = UsersViewHostingVC(viewModel: viewModel)
        self.navigationController.viewControllers.append(vc)
        return navigationController
    }
}

extension UsersCoordinator: UsersNavigationDelegate {
    func navigateToUserAlbums(user: UsersResponse) {
        let coordinator = AlbumsCoordinator(navigationController: self.navigationController)
        self.childCoordinalors.append(coordinator)
        coordinator.navigateToAlbums(user: user)
    }
    
}
