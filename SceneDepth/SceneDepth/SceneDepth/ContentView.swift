//
//  ContentView.swift
//  SceneDepth
//
//  Created by Jakub Gawecki on 09/10/2021.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = arView()
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
