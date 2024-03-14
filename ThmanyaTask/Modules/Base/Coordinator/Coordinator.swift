//
//  Coordinator.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Foundation
import UIKit

protocol NavigationProtocol {
    var backDelegate: BackDelegate? { get set }
}

protocol Coordinator: AnyObject, BackDelegate {
    var navigationController: UINavigationController { get set }
    var childCoordinalors: [Coordinator] { get set }
    
    init(navigationController: UINavigationController)
    
    // This is used if we want to pre apply settings on navigationController or return it to UITabBarController
    @discardableResult func start(backDelegate: BackDelegate?) -> UINavigationController
}

extension Coordinator {
    func back() {
        if let presented = navigationController.presentedViewController {
            presented.dismiss(animated: true)
        } else {
            self.navigationController.popViewController(animated: true)
        }
        if self.childCoordinalors.count > 0 {
            self.childCoordinalors.removeLast()
        }
    }
    
    func backToRoot() {
        self.navigationController.popToRootViewController(animated: true)
        if childCoordinalors.count > 0 {
            childCoordinalors.removeAll()
        }
    }
}

protocol ChildCoordinator: Coordinator {
    init(navigationController: UINavigationController, parentNavigationController: UINavigationController)
}


protocol BackDelegate: AnyObject {
    func back()
    func backToRoot()
}
