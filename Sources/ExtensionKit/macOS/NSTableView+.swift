//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

#if os(macOS)

import Cocoa

public protocol Reuse {
    static var reuseIdentifier: NSUserInterfaceItemIdentifier {get}
}

public extension Reuse {
    static var reuseIdentifier: NSUserInterfaceItemIdentifier {
        NSUserInterfaceItemIdentifier(rawValue: String(describing: self))
    }
}


extension NSTableCellView: Reuse {}


public extension NSTableView {
    
    @inlinable var isSingleClicked: Bool {
        selectedRow >= 0
    }
    
    @inlinable var isSingleSelection: Bool {
        selectedRowIndexes.count == 1
    }
    
    @inlinable var isMultiSelected: Bool {
        selectedRowIndexes.count > 1
    }
    
    @inlinable var isDoubleClicked: Bool {
        clickedRow >= 0
    }
    
    @inlinable func makeView<T: NSTableCellView>(identifier: NSUserInterfaceItemIdentifier? = nil, owner: Any?) -> T {
        let cellIdentifier = identifier ?? T.reuseIdentifier
        let cell = makeView(withIdentifier: cellIdentifier, owner: owner) as? T
        precondition(cell != nil, "Tableview not registered with cell named \(cellIdentifier.rawValue)")
        return cell!
    }
}

#endif
