//
//  AlbumsViewHostingVC.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import SwiftUI

protocol AlbumsNavigationDelegate: AnyObject {
    func navigateToAlbumDetails(album: AlbumsResponse)
}

class AlbumsViewHostingVC: UIHostingController<AlbumsView> {
    let viewModel: AlbumsViewModel
    
    
    init(viewModel: AlbumsViewModel) {
        self.viewModel = viewModel
        super.init(rootView: AlbumsView(viewModel: viewModel))
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationSettings(navigationType: .default)
    }
    
}
