//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

#if os(iOS)
import UIKit

public protocol Reuse: class {
    static var reuseIdentifier: String { get }
}

public extension Reuse {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}

extension UICollectionViewCell: Reuse { }

public extension UICollectionView{
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
#endif



