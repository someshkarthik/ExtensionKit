//
//  File.swift
//  
//
//  Created by somesh karthik on 26/01/21.
//

import AVFoundation

public extension AVFileType {
    func stringValue() -> String {
        var string = ""
        switch self {
            case .mov: string += "mov"
            case .mp4: string += "mp4"
            case .m4v: string += "m4v"
            case .m4a: string += "m4a"
            case .mobile3GPP: string += "3gp"
            case .mobile3GPP2: string += "3g2"
            case .caf: string += "caf"
            case .wav: string += "wav"
            case .aiff: string += "aif"
            case .aifc: string += "aifc"
            case .amr: string += "amr"
            case .mp3: string += "mp3"
            case .au: string += "au"
            case .ac3: string += "ac3"
            case .eac3: string += "eac3"
            case .jpg: string += "jpg"
            case .dng: string += "dng"
            case .heic: string += "heic"
            case .avci: string += "avci"
            case .heif: string += "heif"
            case .tif: string += "tiff"
            default: fatalError("AVFileType: \(self.rawValue) not supported")
        }
        return string
    }
    
    var isImageFileTypeSupported: Bool {
        return self == .heic || self == .jpg || self == .tif
    }
    
    var isVideoFileTypeSupported: Bool {
        return self == .mov || self == .mp4 || self == .mobile3GPP || self == .mobile3GPP2
    }
}

