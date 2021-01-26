//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

import Foundation

public extension NSObject {
    func perform(_ block: @convention(block) @escaping ()-> Void,afterDelay delay: TimeInterval) {
        perform(#selector(fireBlock(_:)), with: block, afterDelay: delay)
    }
    
    @objc private func fireBlock(_ block: ()-> Void) {
        block()
    }
}

