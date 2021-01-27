//
//  File.swift
//  
//
//  Created by somesh karthik on 26/01/21.
//

import Foundation

public extension URLSession {
    static var ephemeral: URLSession {
        URLSession(configuration: .ephemeral)
    }
}
