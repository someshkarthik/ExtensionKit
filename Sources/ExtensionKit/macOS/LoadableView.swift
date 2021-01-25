//
//  File.swift
//  
//
//  Created by somesh karthik on 25/01/21.
//

#if os(macOS)

import Cocoa

public protocol LoadableView: class {
    var mainView: NSView? { get set }
    func load(fromNIBNamed nibName: String) -> Bool
    func add(toView parentView: NSView)
}

public extension LoadableView where Self: NSView {
    func load(fromNIBNamed nibName: String? = nil) -> Bool {
        var nibObjects: NSArray?
        let name = nibName ?? String(describing: self)
        let nibName = NSNib.Name(stringLiteral: name)
        
        guard Bundle.main.loadNibNamed(nibName, owner: self, topLevelObjects: &nibObjects),
              let view = nibObjects?.first(where: {$0 is NSView}) as? NSView else {
            return false
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        self.mainView = view
        
        return true
    }
    
    func add(toView parentView: NSView) {
        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
    }
}

#endif

