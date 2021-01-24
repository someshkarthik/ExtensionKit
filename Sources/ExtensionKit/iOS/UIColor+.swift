//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

#if os(iOS)

import UIKit

public extension UIColor {
    @available(iOS 13, *)
    static func setAppearance(dark: UIColor,light: UIColor) -> UIColor {
        return UIColor {(trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                return dark
            } else {
                return light
            }
        }
    }
    
    static func setColor(dark: UIColor,light: UIColor) -> UIColor {
        if #available(iOS 13, *){
            return .setAppearance(dark: dark, light: light)
        } else {
            return light
        }
    }
    
    func resolveDynamicColor(with traitCollection: UITraitCollection) -> UIColor{
        if #available(iOS 13, *){
            return resolvedColor(with: traitCollection)
        } else {
            return self
        }
    }
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: rgb >> 16 & 0xFF,
            green: rgb >> 8 & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
    
    var inverted: UIColor {
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        UIColor.red.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: (1 - r), green: (1 - g), blue: (1 - b), alpha: a)
    }
}


#endif

