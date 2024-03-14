//
//  AlbumDetailsCoordinator.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import UIKit

class AlbumDetailsCoordinator: Coordinator {
    var childCoordinalors: [Coordinator] = []
    var navigationController: UINavigationController
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @discardableResult func start(backDelegate: BackDelegate?) -> UINavigationController {
        return navigationController
    }
    
    
    func navigateToAlbumsDetails(album: AlbumsResponse) {
        let viewModel = PhotosViewModel(
            album: album,
            navigationDelegate: self,
            backDelegate: self)
        let vc = PhotosHostingVC(viewModel: viewModel)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}

extension AlbumDetailsCoordinator: PhotosNavigationDelegate {
    func presentFullScreenPhoto(url: URL) {
        let vc = FullScreenPhotoHostingVC(photoUrl: url)
        vc.modalPresentationStyle = .popover
        self.navigationController.present(vc, animated: true)
    }
}
