//
//  File.swift
//  
//
//  Created by somesh karthik on 26/01/21.
//

import AVFoundation

public extension AVCaptureDevice.Position {
    func opposite() -> AVCaptureDevice.Position {
        switch self {
            case .front: return .back
            case .back: return .front
            case .unspecified: return .unspecified
            @unknown default:
                fatalError("unknown case should \(self)")
        }
    }
}
