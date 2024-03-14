//
//  UIViewController+Extension.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/14/24.
//

import UIKit

extension UIViewController {
    func dismissKeyboard() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}
