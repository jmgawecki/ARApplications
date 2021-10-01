//
//  ViewModel.swift
//  WalkingRobot
//
//  Created by Jakub Gawecki on 30/09/2021.
//

import SwiftUI
import RealityKit
import Combine

enum RobotMode {
    case walk
    case turnAround
    case beingPitched
}

class ViewModel: ObservableObject {
    fileprivate var subscriptions: Set<AnyCancellable> = []
    var robot: Entity?
    
    
    func addRobot(to planeAnchor: AnchorEntity) {
        Entity.loadAsync(named: "toy_robot")
            .sink { completion in
                switch completion {
                case .finished:
                    print("Ok")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { robot in
                // Entity should be added before the animation is started.
                planeAnchor.addChild(robot)
                if let walkingAnimation = robot.availableAnimations.first {
                    robot.playAnimation(walkingAnimation.repeat(duration: .infinity),
                                        transitionDuration: 1.25,
                                        blendLayerOffset: 0,
                                        separateAnimatedValue: false,
                                        startsPaused: false)

                }
                self.robot = robot
                self.startWalking()
            }
            .store(in: &subscriptions)
    }


    func createHPlaneAnchor() -> AnchorEntity {
        let planeAnchor = AnchorEntity(plane: .horizontal,
                                       classification: .floor,
                                       minimumBounds: [1,1])
        return planeAnchor
    }
    
    func startWalking() {
        guard let robot = robot else {
            return
        }
        robot.generateCollisionShapes(recursive: true)
        let currentTransform = robot.transform
        let currentTranslation = currentTransform.translation
        let newTranslation: SIMD3<Float> = [currentTranslation.x + 0.5, currentTranslation.y, currentTranslation.z]
        let transform = Transform(scale: currentTransform.scale, rotation: currentTransform.rotation, translation: newTranslation)
        robot.move(to: transform, relativeTo: nil, duration: 6)
    }

}
