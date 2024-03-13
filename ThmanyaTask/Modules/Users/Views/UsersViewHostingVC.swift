//
//  UsersViewHostingVC.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import SwiftUI

protocol HomeNavigationDelegate: AnyObject {
    func navigateToAlbumDetails(id: String)
}

class UsersViewHostingVC: UIHostingController<UsersView> {
    let viewModel: UsersViewModel
    
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(rootView: UsersView(viewModel: viewModel))
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationSettings(navigationType: .noNavigationBar)
    }
    
}
