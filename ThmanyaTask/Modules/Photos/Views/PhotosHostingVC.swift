//
//  AlbumDetailsHostingVC.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import SwiftUI

protocol PhotosNavigationDelegate: AnyObject {
    func presentFullScreenPhoto(url: URL)
}

class PhotosHostingVC: UIHostingController<PhotosView> {
    
    let viewModel: PhotosViewModel
    
    init(viewModel: PhotosViewModel) {
        self.viewModel = viewModel
        super.init(rootView: PhotosView(viewModel: viewModel))
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationSettings(navigationType: .default)
    }

}
