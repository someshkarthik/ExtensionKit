//
//  File.swift
//  
//
//  Created by somesh karthik on 26/01/21.
//

import Metal

public extension MTLComputeCommandEncoder {
    func dispatch(pipeline: MTLComputePipelineState, width: Int, height: Int) {
        let w = pipeline.threadExecutionWidth
        let h = pipeline.maxTotalThreadsPerThreadgroup / w
        
        let threadGroupSize = MTLSizeMake(w, h, 1)
        let threadGroups = MTLSizeMake(
            (width  + threadGroupSize.width  - 1) / threadGroupSize.width,
            (height + threadGroupSize.height - 1) / threadGroupSize.height, 1)
        
        setComputePipelineState(pipeline)
        dispatchThreadgroups(threadGroups, threadsPerThreadgroup: threadGroupSize)
    }
}

