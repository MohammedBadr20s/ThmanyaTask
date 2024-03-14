//
//  UINavigationController+Extension.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import UIKit

enum NavigationType {
    case `default`
    case defaultWithCustomFont(_ Font: UIFont)
    case largeTitle
    case noNavigationBar
}

extension UINavigationController {
    func setNavigationSettings(navigationType: NavigationType) {
        switch navigationType {
        case .default:
            self.navigationItem.largeTitleDisplayMode = .never
            self.viewControllers.last?.navigationItem.largeTitleDisplayMode = .never
            self.navigationBar.setCustomTitleFont(font: FontFactory.getFont(.sansArabic, .medium, 17))
            self.addBackButton()
            self.setNavigationBarHidden(false, animated: true)
        case .defaultWithCustomFont(let font):
            self.navigationItem.largeTitleDisplayMode = .never
            self.viewControllers.last?.navigationItem.largeTitleDisplayMode = .never
            self.navigationBar.setCustomTitleFont(font: font)
            self.addBackButton()
            self.setNavigationBarHidden(false, animated: true)
        case .largeTitle:
            self.navigationBar.prefersLargeTitles = true
            self.viewControllers.last?.navigationItem.largeTitleDisplayMode = .always
            self.addBackButton()
            self.setNavigationBarHidden(false, animated: true)
        case .noNavigationBar:
            self.navigationItem.largeTitleDisplayMode = .never
            self.viewControllers.last?.navigationItem.largeTitleDisplayMode = .never
            self.setNavigationBarHidden(true, animated: true)

        }
        self.hideHairline()
    }
    
    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }
    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }
    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
    
    func addBackButton(){
        let image = UIImage(named: "backArrow")
        let back = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backPressed))
        self.viewControllers.last?.navigationItem.leftBarButtonItem = back
        self.viewControllers.last?.navigationItem.leftBarButtonItem?.tintColor = .black
        
    }
    
    @objc func backPressed(){
        guard self.viewControllers.count == 1 else {
            self.popViewController(animated: true)
            return
        }
    }
}

extension UINavigationBar {
    func setCustomTitleFont(font: UIFont, color: UIColor = .black) {
        let appearance = UINavigationBarAppearance()

        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: color]

        appearance.titleTextAttributes = [.font: font]
        self.compactAppearance = appearance
        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance
    }

    func setCustomLargeTitleFont(font: UIFont, color: UIColor = .black) {
        let appearance = UINavigationBarAppearance()

        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: color]

        appearance.largeTitleTextAttributes = [.font: font]
        self.compactAppearance = appearance
        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance
    }
}
