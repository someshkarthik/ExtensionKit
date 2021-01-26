//
//  File.swift
//  
//
//  Created by somesh karthik on 26/01/21.
//

#if os(macOS)

import Cocoa

public extension NSCursor {
    func pushIfNeeded() {
        if NSCursor.current != self {
            push()
        }
    }
    
    func popIfNeeded() {
        if NSCursor.current == self {
            pop()
        }
    }
}

#endif
