//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

#if os(iOS)

import UIKit

extension UITableViewCell: Reuse {}

public extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

public extension UITableViewCell {
    func addDecoratorView(_ color: UIColor,
                          bottomInset: CGFloat = 1.0) {
        let decoratorView = UIView()
        addSubview(decoratorView)
        
        decoratorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            decoratorView.topAnchor.constraint(equalTo: self.topAnchor),
            decoratorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            decoratorView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -bottomInset),
            decoratorView.widthAnchor.constraint(equalToConstant: 4),
            
        ])
        
        decoratorView.backgroundColor = color
    }
}

/*
 public extension UITableViewCell {
 func setBackgroundView(_ listSelectionColor: UIColor = ZColor.listSelectionColor){
 let selectedBackgroundView = UIView()
 selectedBackgroundView.backgroundColor = listSelectionColor
 self.selectedBackgroundView = selectedBackgroundView
 }
 }
 */


#endif


