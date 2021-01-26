//
//  File.swift
//  
//
//  Created by somesh karthik on 26/01/21.
//

#if os(macOS)

import Cocoa

public extension NSView {
    func snapShot() -> NSImage {
        let rep = bitmapImageRepForCachingDisplay(in: bounds)!
        cacheDisplay(in: bounds, to: rep)
        
        let img = NSImage(size: bounds.size)
        img.addRepresentation(rep)
        return img
    }
    
    var backgroundColor: NSColor? {
        get {
            if let backgroundColor = layer?.backgroundColor {
                return NSColor(cgColor: backgroundColor)
            }
            return nil
        }
        set {
            createLayerIfNeeded()
            layer?.backgroundColor = newValue?.cgColor
        }
    }
    
    func createLayerIfNeeded() {
        if layer == nil {
            wantsLayer = true
        }
    }
}


#endif

