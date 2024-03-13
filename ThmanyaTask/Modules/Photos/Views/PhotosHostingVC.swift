//
//  AlbumDetailsHostingVC.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import SwiftUI

protocol AdlbumDetailsNavigationDelegate: AnyObject {
    
}

class AlbumDetailsHostingVC: UIHostingController<AlbumDetailsView> {
    
    let viewModel: AlbumDetailsViewModel
    
    init(viewModel: AlbumDetailsViewModel) {
        self.viewModel = viewModel
        super.init(rootView: AlbumDetailsView(viewModel: viewModel))
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationSettings(navigationType: .default)
    }

}
