//
//  AlbumsCoordinator.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import UIKit

class AlbumsCoordinator: Coordinator {
    var childCoordinalors: [Coordinator] = []
    var navigationController: UINavigationController
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @discardableResult func start(backDelegate: BackDelegate?) -> UINavigationController {
        return navigationController
    }
    
    func navigateToAlbums(user: UsersResponse) {
        let viewModel = AlbumsViewModel(
            user: user,
            navigationDelegate: self,
            backDelegate: self)
        let vc = AlbumsViewHostingVC(viewModel: viewModel)
        self.navigationController.pushViewController(vc, animated: true)
    }
}

extension AlbumsCoordinator: AlbumsNavigationDelegate {
    func navigateToAlbumDetails(album: AlbumsResponse) {
        let coordinator = AlbumDetailsCoordinator(navigationController: self.navigationController)
        self.childCoordinalors.append(coordinator)
        coordinator.navigateToAlbumsDetails(album: album)
    }
    
}
