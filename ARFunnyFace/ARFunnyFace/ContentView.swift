//
//  ContentView.swift
//  ARFunnyFace
//
//  Created by Jakub Gawecki on 29/09/2021.
//

import SwiftUI
import RealityKit
import ARKit

enum ActionButtonType {
    case previous
    case next
    case shutter
}

var arView: ARView?

struct ContentView : View {
    @State var propID: Int = 0
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(propID: $propID).edgesIgnoringSafeArea(.all)
            HStack {
                Spacer()
                ButtonView(propID: $propID, imageName: "PreviousButton", buttonType: .previous)
                Spacer()
                ButtonView(propID: $propID, imageName: "ShutterButton", buttonType: .shutter)
                Spacer()
                ButtonView(propID: $propID, imageName: "NextButton", buttonType: .next)
                Spacer()
            }
        }
    }
}

struct ButtonView: View {
    @Binding var propID: Int 
    let imageName: String
    let buttonType: ActionButtonType
    var body: some View {
        Button {
            switch buttonType {
            case .previous:
                self.propID = self.propID <= 0 ? 0 : self.propID - 1
            case .next:
                self.propID = self.propID >= 2 ? 2 : self.propID + 1
            case .shutter:
                takeSnapshot()
            }
        } label: {
            Image(imageName).clipShape(Circle())
        }
    }
    
    func takeSnapshot() {
        arView?.snapshot(saveToHDR: false, completion: { image in
            guard let data = image?.pngData() else {
                return
            }

            let compressedImage = UIImage(data: data)
            
            guard let readyImage = compressedImage else { return }
            
            UIImageWriteToSavedPhotosAlbum(readyImage, nil, nil, nil)
        })
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var propID: Int
    
    func makeUIView(context: Context) -> ARView {
    
        arView = ARView(frame: .zero)
        
        guard let arView = arView else {
            return ARView(frame: .zero)
        }
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        let faceConfig = ARFaceTrackingConfiguration()
        uiView.session.run(faceConfig, options: [.resetTracking, .removeExistingAnchors])
        uiView.scene.anchors.removeAll()
        
        switch propID {
        case 0:
            let eyes = try? Experience.loadEyes()
            guard let arAnchor = eyes else { return }
            uiView.scene.anchors.append(arAnchor)
        case 1:
            let glasses = try? Experience.loadGlasses()
            guard let glasses = glasses else { return }
            uiView.scene.anchors.append(glasses)
        case 2:
            let mustache = try? Experience.loadMoustache()
            guard let mustache = mustache else { return }
            uiView.scene.anchors.append(mustache)
        default:
            break
        }
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
