//
//  File.swift
//  
//
//  Created by somesh karthik on 24/01/21.
//

import Foundation

public typealias ResponseDictionary = [AnyHashable:Any]

public extension Dictionary {
    subscript<T>(keyPath keyPath: String) -> T? {
        get {
            guard let keyPath = Dictionary.keyPathKeys(forKeyPath: keyPath)
            else { return nil }
            return getValue(forKeyPath: keyPath)
        }
        set {
            guard let keyPath = Dictionary.keyPathKeys(forKeyPath: keyPath),
                  let newValue = newValue else { return }
            self.setValue(newValue, forKeyPath: keyPath)
        }
    }
    
    static private func keyPathKeys(forKeyPath: String) -> [Key]? {
        let keys = forKeyPath.components(separatedBy: ".")
            .reversed().compactMap({ $0 as? Key })
        return keys.isEmpty ? nil : keys
    }
    
    // recursively (attempt to) access queried subdictionaries
    // (keyPath will never be empty here; the explicit unwrapping is safe)
    private func getValue<T>(forKeyPath keyPath: [Key]) -> T? {
        guard keyPath.count != 1 else { return self[keyPath.last!] as? T }
        guard let value = self[keyPath.last!] else { return nil }
        return (value as? [Key : Any])
            .flatMap { $0.getValue(forKeyPath: Array(keyPath.dropLast())) }
    }
    
    // recursively (attempt to) access the queried subdictionaries to
    // finally replace the "inner value", given that the key path is valid
    private mutating func setValue(_ value: Any, forKeyPath keyPath: [Key]) {
        guard self[keyPath.last!] != nil else { return }
        if keyPath.count == 1 {
            (value as? Value).map { self[keyPath.last!] = $0 }
        }
        else if var subDict = self[keyPath.last!] as? [Key: Value] {
            subDict.setValue(value, forKeyPath: Array(keyPath.dropLast()))
            (subDict as? Value).map { self[keyPath.last!] = $0 }
        }
    }
}


public extension Dictionary {
    subscript<T: Mappable>(key: String) -> T? {
        guard let keyPath = Dictionary.keyPathKeys(forKeyPath: key),
              let result: ResponseDictionary = getValue(forKeyPath: keyPath)
        else { return nil }
        
        //        guard let key = key as? Key,
        //              let result = self[key] as? ResponseDictionary
        //        else {return  nil}
        return T.mapToModel(result)
    }
    
    subscript<T: Mappable>(key: String) -> [T]? {
        guard let keyPath = Dictionary.keyPathKeys(forKeyPath: key),
              let result: [ResponseDictionary] = getValue(forKeyPath: keyPath)
        else { return nil }
        //        guard let key = key as? Key,
        //              let result = self[key] as? [ResponseDictionary]
        //        else {return  nil}
        return T.mapToModel(result)
    }
    
    subscript<T: Mappable>() -> T {
        return T.mapToModel(self)
    }
}

public extension Array where Element == ResponseDictionary {
    subscript<T: Mappable>() -> [T] {
        return T.mapToModel(self)
    }
}

public protocol Mappable {
    static func mapToModel(_ dict: ResponseDictionary) -> Self
    static func mapToModel(_ dict: [ResponseDictionary]) -> [Self]
}

public extension Mappable {
    static func mapToModel(_ dict: [ResponseDictionary]) -> [Self] {
        var mappableArray = [Self]()
        for dictVal in dict {
            let mappable: Self = dictVal[]
            mappableArray.append(mappable)
        }
        return mappableArray
    }
}

public extension Dictionary {
    func jsonString() -> String {
        var jsonString: String? = nil
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            jsonString = String(data: jsonData, encoding: .utf8)
        } catch { }
        
        guard let outString = jsonString?.replacingOccurrences(of: "\\/", with: "/")
        else { return "" }
        
        return outString
    }
}

public extension Dictionary {
    mutating func updateIfNotNil(_ value: Value?,forKey key: Key) {
        if let value = value {
            updateValue(value, forKey: key)
        }
    }
}


