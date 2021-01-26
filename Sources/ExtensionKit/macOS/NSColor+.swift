//
//  File.swift
//  
//
//  Created by somesh karthik on 26/01/21.
//

#if os(macOS)

import Cocoa

public extension NSColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            calibratedRed: CGFloat(red) / 255.0,
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
}


#endif

