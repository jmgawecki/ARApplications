//
//  arView.swift
//  SceneDepth
//
//  Created by Jakub Gawecki on 09/10/2021.
//

import Foundation
import RealityKit
import ARKit

class arView: ARView, ARSessionDelegate {
    
    required init() {
        super.init(frame: .zero)
        
        session.delegate = self
        
        let configuration = ARWorldTrackingConfiguration()
        
        if type(of: configuration).supportsFrameSemantics(.sceneDepth) {
            configuration.frameSemantics = .sceneDepth
        }
        
        session.run(configuration)
    }
    
    @MainActor @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor @objc required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard let depthData = frame.sceneDepth else { return }
        print(depthData.depthMap)
    }
}
