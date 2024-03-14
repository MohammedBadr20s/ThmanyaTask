//
//  FullScreenPhotoHostingVC.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/14/24.
//

import SwiftUI

class FullScreenPhotoHostingVC: UIHostingController<FullScreenPhotoView> {
    
    var photoUrl: URL
    
    init(photoUrl: URL) {
        self.photoUrl = photoUrl
        super.init(rootView: FullScreenPhotoView(photoUrl: photoUrl))
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationSettings(navigationType: .noNavigationBar)
    }

}
