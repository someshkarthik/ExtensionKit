//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

#if os(macOS)

import Cocoa

public extension String {
    var cellIdentifier: NSUserInterfaceItemIdentifier {
        NSUserInterfaceItemIdentifier(rawValue: self)
    }
}


#endif

