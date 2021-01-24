//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

import Foundation


//use this operator to unwrap a optional-value if a non-nil variable is being assigned inside the if-let block
infix operator =?
public func =?<T>(target: inout T, newValue: T?) {
    if let unwrapped = newValue {
        target = unwrapped
    }
}


public postfix func ++<T: Numeric>(lhs: inout T) {
    lhs += 1
}

public postfix func --<T: Numeric>(lhs: inout T) {
    lhs -= 1
}
