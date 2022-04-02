//
//  MyARView+ML.swift
//  HandPoseDetector
//
//  Created by Jakub Gawecki on 11/10/2021.
//

import Vision
import ARKit

extension MyARView: ARSessionDelegate {
    var handPoseRequestComputed: VNDetectHumanHandPoseRequest {
        let request = VNDetectHumanHandPoseRequest { request, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            if let observations = (request.results as? [VNDetectedObjectObservation])?.first {
                print(observations)
            }
            
        }
        request.maximumHandCount = 1
        request.revision = VNDetectHumanHandPoseRequestRevision1
        return request
    }
    
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        frameCounter += 1
        if frameCounter % handPosePredictionInterwal == 0 {
        
        let pixelBuffer = frame.capturedImage

        let handPoseRequest = VNDetectHumanHandPoseRequest()
        handPoseRequest.maximumHandCount = 1
        handPoseRequest.revision = VNDetectHumanHandPoseRequestRevision1
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        
        
        do {
            try handler.perform([handPoseRequest])
        } catch let error {
            print(error.localizedDescription)
        }
        
        guard let handPose = handPoseRequest.results?.first else {
            return
        }
        
        
            guard let keypointsMultiArray = try? handPose.keypointsMultiArray()
            else { fatalError() }
            
            var model: HandSuperPoseTrainModel
            do {
                model = try HandSuperPoseTrainModel(configuration: MLModelConfiguration())
            } catch let error {
                fatalError(error.localizedDescription)
            }
        
            do {
                let handPosePrediction = try model.prediction(poses: keypointsMultiArray)
                let confidence = handPosePrediction.labelProbabilities[handPosePrediction.label]!
                print(confidence)
            } catch let error {
                fatalError(error.localizedDescription)
            }
        }
    }
}
