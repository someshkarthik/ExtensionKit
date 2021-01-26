//
//  File.swift
//  
//
//  Created by somesh karthik on 26/01/21.
//

import Foundation

public extension URL {
    init?(string: String?) {
        guard let string = string else {
            return nil
        }
        
        self.init(string: string)
    }
}
