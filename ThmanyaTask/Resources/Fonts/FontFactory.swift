//
//  FontFactory.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import UIKit.UIFont
import SwiftUI

struct FontFactory {
    static func getFont(_ family: FontFamily, _ weight: FontWeight, _ size: CGFloat) -> UIFont {
        return UIFont(name: generateFontName(family, weight), size: size) ?? .systemFont(ofSize: size)
    }
    static func swiftUIFont(_ family: FontFamily, _ weight: FontWeight, _ size: CGFloat) -> Font {
        return Font(getFont(family, weight, size))
    }
    private static func generateFontName(_ family: FontFamily, _ weight: FontWeight) -> String {
        return "\(family.rawValue)\(weight.rawValue)"
    }
}

enum FontFamily: String {
    case sansArabic = "IBMPlexSansArabic-"
}

enum FontWeight: String {
    case bold = "Bold"
    case extraLight = "ExtraLight"
    case light = "Light"
    case medium = "Medium"
    case regular = "Regular"
    case semiBold = "SemiBold"
    case thin = "Thin"
}
