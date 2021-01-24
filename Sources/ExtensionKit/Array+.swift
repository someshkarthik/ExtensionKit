//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

import Foundation

public extension Array {
    @inlinable func map<T>(_ transform: (Index,Element) throws -> T)  rethrows -> [T] {
        var index = 0
        var result: [T] = []
        for element in self {
            try? result.append(transform(index, element))
            index++
        }
        return result
    }
    
    @inlinable func forEach(_ body: (Index, Element) throws -> Void) rethrows{
        var index: Int = 0
        for element in self {
            try? body(index, element)
            index++
        }
    }
    
    @inlinable mutating func forEachMutating(_ body: (Index, inout Element) throws -> Void) rethrows {
        for index in 0..<count {
            try? body(index, &self[index])
        }
    }
    
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
    mutating func remove(at indexes: [Int]) {
        for index in indexes.sorted(by: >) {
            remove(at: index)
        }
    }
    
    @discardableResult
    mutating func move(from currentPos: Int,to newPos: Int) -> Bool{
        if indices ~= currentPos && indices ~= newPos {
            let element = remove(at: currentPos)
            insert(element, at: newPos)
            return true
        }
        return false
    }
}

public extension Array where Element: Equatable {
    
    @discardableResult
    mutating func remove(element: Element) -> Element? {
        var indexOfElementToBeRemoved: Int?
        
        forEach { (index, item) in
            if item == element {
                indexOfElementToBeRemoved = index
            }
        }
        
        if let index = indexOfElementToBeRemoved {
            return remove(at: index)
        }
        
        return nil
    }
    
    mutating func remove(collection elements: Element...) {
        elements.forEach({remove(element: $0)})
    }
    
    mutating func remove(arrayOf elements: [Element]) {
        elements.forEach({remove(element: $0)})
    }
    
}


