//
//  File.swift
//  
//
//  Created by somesh karthik on 26/01/21.
//

#if os(macOS)

import Cocoa

public extension NSViewController {
    static func loadFromStoryBoard(_ name: String? = nil) -> Self{
        let storyboardName = name ?? ExtensionKit.mainStoryBoardName
        let storyBoard = NSStoryboard(name: storyboardName, bundle: nil)
        return storyBoard.instantiateController(withIdentifier: stringRepresentation) as! Self
    }
    
    static var stringRepresentation: String {
        String(describing: Self.self)
    }
}

#endif
