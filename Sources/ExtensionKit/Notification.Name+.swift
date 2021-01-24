//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

import Foundation

public extension Notification.Name {
    // use this functions to post a notification with Notification.Name
    func post(center: NotificationCenter = .default, object: Any? = nil,
              userInfo: [AnyHashable : Any]? = nil) { center.post(name: self, object: object, userInfo: userInfo)
    }
    
    
    /// use this functiona to observe the respective notification posted using Notification.Name
    /// - Parameters:
    ///   - center: It is notiication center object. It will default NotificationCenter if none is provided.
    ///   - object: If any object to be passed when notification is trigged
    ///   - queue: On which queue this notificaition should be triggered.
    ///   - using: Block of code executes when notification is triggered
    /// - Returns: returns a reference to the notification which is being observed.
    @discardableResult
    func onPost(center: NotificationCenter = .default, object: Any? = nil,
                queue: OperationQueue? = nil,
                using: @escaping (Notification) -> Void) -> NSObjectProtocol {
        return center.addObserver(forName: self, object: object, queue: queue, using: using)
    }
}
