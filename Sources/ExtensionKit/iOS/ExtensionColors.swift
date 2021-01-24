//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

#if os(iOS)

import UIKit
public struct ExtensionColors {
    public static var seperatorColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor.setAppearance(dark: UIColor.separator, light: UIColor(red:0.88, green:0.88, blue:0.89, alpha:1.00))
        } else {
            return UIColor(red:0.88, green:0.88, blue:0.89, alpha:1.00)
        }
    }
    
    public static var bgColorWhite: UIColor {
        if #available(iOS 13, *) {
            return UIColor.setAppearance(dark: UIColor.secondarySystemBackground, light:  UIColor.white)
        } else {
            return UIColor.white
        }
    }
    
    public static var tintColor: UIColor = .blue
}

#endif



