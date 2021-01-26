//
//  File.swift
//  
//
//  Created by somesh karthik on 26/01/21.
//

import QuartzCore

public extension CGSize {
    static func aspectFill(videoSize: CGSize, boundingSize: CGSize) -> CGSize {
        
        var size = boundingSize
        let mW = boundingSize.width / videoSize.width;
        let mH = boundingSize.height / videoSize.height;
        
        if( mH > mW ) {
            size.width = boundingSize.height / videoSize.height * videoSize.width;
        }
        else if ( mW > mH ) {
            size.height = boundingSize.width / videoSize.width * videoSize.height;
        }
        
        return size;
    }
    
    static func aspectFit(videoSize: CGSize, boundingSize: CGSize) -> CGSize {
        
        var size = boundingSize
        let mW = boundingSize.width / videoSize.width;
        let mH = boundingSize.height / videoSize.height;
        
        if( mH < mW ) {
            size.width = mH * videoSize.width;
        }
        else if( mW < mH ) {
            size.height = mW * videoSize.height;
        }
        
        return size;
    }
}


public extension CGSize {
    
    func aspectFillIn(boundingSize: CGSize) -> CGSize {
        let mW = boundingSize.width / width;
        let mH = boundingSize.height / height;
        var newSize = boundingSize
        if( mH > mW ) {
            newSize.width = boundingSize.height / height * width;
        }
        else if ( mW > mH ) {
            newSize.height = boundingSize.width / width * height;
        }
        
        return newSize
    }
    
    func aspectFitTo(boundingSize: CGSize) -> CGSize {
        var newSize = boundingSize
        let mW = boundingSize.width / width;
        let mH = boundingSize.height / height;
        
        if( mH < mW ) {
            newSize.width = boundingSize.height / height * width;
        }
        else if( mW < mH ) {
            newSize.height = boundingSize.width / width * height;
        }
        
        return newSize
    }
}
