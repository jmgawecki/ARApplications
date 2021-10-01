//
//  ContentView.swift
//  WalkingRobot
//
//  Created by Jakub Gawecki on 30/09/2021.
//

import SwiftUI
import RealityKit
import Combine

struct ContentView : View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        return ARViewContainer(viewModel: viewModel).edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: ViewModel
    
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        let firstPlaneAnchor = viewModel.createHPlaneAnchor()
        viewModel.addRobot(to: firstPlaneAnchor)
        
        arView.scene.anchors.append(firstPlaneAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
