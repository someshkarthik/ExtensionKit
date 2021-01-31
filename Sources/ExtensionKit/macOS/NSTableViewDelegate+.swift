//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

#if os(macOS)

import Cocoa

@objc public protocol ExtensionTableViewDelegate: NSTableViewDelegate {
    @objc optional func tableViewSingleSelection(_ tableView: NSTableView,didSelectRowAt row: Int, notification: Notification)
    @objc optional func tableViewMultiSelection(_ tableView: NSTableView,didSelectedRows indexes: IndexSet,notification: Notification)
}

public extension ExtensionTableViewDelegate {
    @objc func tableViewSelectionDidChange(_ notification: Notification) {
        let tableView = notification.object as! NSTableView
        
        guard tableView.isSingleClicked else {
            return
        }
        
        if tableView.isSingleSelection &&
            self.tableViewSingleSelection != nil {
            let row = tableView.selectedRow
            self.tableViewSingleSelection?(tableView, didSelectRowAt: row, notification: notification)
        } else if self.tableViewMultiSelection != nil {
            let indexes = tableView.selectedRowIndexes
            self.tableViewMultiSelection?(tableView, didSelectedRows: indexes, notification: notification)
        }
    }
}

#endif
