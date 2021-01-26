//
//  File.swift
//  
//
//  Created by somesh karthik on 26/01/21.
//

#if os(macOS)

import Cocoa

extension NSCollectionViewItem: Reuse {}

public extension NSCollectionView {
    func registerReusableItem<T: NSCollectionViewItem>(_: T.Type) {
        self.register(T.self, forItemWithIdentifier: T.reuseIdentifier)
    }
    
    func registerReusableNib<T: NSCollectionViewItem>(_: T.Type) {
        register(NSNib(nibNamed: T.reuseIdentifier.rawValue, bundle: nil), forItemWithIdentifier: T.reuseIdentifier)
    }
    
    func dequeueItem<T: NSCollectionViewItem>(_ indexPath: IndexPath) -> T {
        let item = makeItem(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
        
        precondition(item != nil, "Unable to dequeu item with identifier \(T.reuseIdentifier)")
        
        return item!
    }
}


#endif


