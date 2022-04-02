//
//  myARView.swift
//  HandPoseDetector
//
//  Created by Jakub Gawecki on 11/10/2021.
//


import RealityKit
import UIKit
import ARKit


class MyARView: ARView {
    var frameCounter: Int = 1 {
        didSet {
            if frameCounter == 11 {
                frameCounter = 1
            }
        }
    }
    
    var handPosePredictionInterwal = 10
    
    required init() {
        super.init(frame: .zero)
        session.delegate = self
        let configuration = ARFaceTrackingConfiguration()
        
        session.run(ARFaceTrackingConfiguration())
        
    }
    
    @MainActor @objc override required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    @MainActor @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
