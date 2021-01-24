//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

#if os(iOS)

import UIKit

public extension UIWindow {
    /// Change the root view controller of the window
    ///
    /// - Parameters:
    ///   - controller: controller to set
    ///   - options: options of the transition
    func setRootViewController(_ controller: UIViewController, duration: TimeInterval = 0.3) {
        
        backgroundColor = ExtensionKit.windowTransitionBackgroundColor
        rootViewController = controller
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve) {} completion: { (_)
            in
            self.backgroundColor = .clear
        }
    }
    
    func topViewController() ->  UIViewController? {
        return getTopViewController(vc: rootViewController)
    }
    
    private func getTopViewController(vc : UIViewController?) -> UIViewController? {
        if let rootVc = vc?.presentedViewController as? UINavigationController{
            return  getTopViewController(vc: rootVc.viewControllers.last)
        }
        else if let rootVc = vc?.presentedViewController{
            return getTopViewController(vc: rootVc)
        }
        return vc
    }
}


#endif

