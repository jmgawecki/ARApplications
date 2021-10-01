//
//  ViewController.swift
//  TinyTankToy
//
//  Created by Jakub Gawecki on 26/09/2021.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    fileprivate lazy var buttonForwardTank: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(button)
        button.setImage(ControlButton.tankForward, for: .normal)
        button.addTarget(self, action: #selector(forwardTankTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func  forwardTankTapped() {
        tankAnchor?.notifications.tankForward.post()
    }
    
    fileprivate lazy var buttonTankLeft: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(button)
        button.setImage(ControlButton.tankLeft, for: .normal)
        button.addTarget(self, action: #selector(leftTankTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func  leftTankTapped() {
        tankAnchor?.notifications.tankLeft.post()
    }
    
    fileprivate lazy var buttonTankRight: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(button)
        button.setImage(ControlButton.tankRight, for: .normal)
        button.addTarget(self, action: #selector(rightTankTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func  rightTankTapped() {
        tankAnchor?.notifications.tankRight.post()
    }
    
    fileprivate lazy var buttonTurretLeft: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(button)
        button.setImage(ControlButton.turretLeft, for: .normal)
        button.addTarget(self, action: #selector(leftTurredTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func leftTurredTapped() {
        tankAnchor?.notifications.turretLeft.post()
    }
    
    fileprivate lazy var buttonTurretRight: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(button)
        button.setImage(ControlButton.turretRight, for: .normal)
        button.addTarget(self, action: #selector(rightTurredTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func rightTurredTapped() {
        tankAnchor?.notifications.turretRight.post()
    }
    
    fileprivate lazy var buttonFireTank: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(button)
        button.setImage(ControlButton.fire, for: .normal)
        button.addTarget(self, action: #selector(fireTankTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func fireTankTapped() {
        tankAnchor?.notifications.cannonFire.post()
    }
    
    fileprivate lazy var buttonPanel: UIStackView = {
        let upperStackView = UIStackView(arrangedSubviews: [buttonTurretLeft, buttonFireTank, buttonTurretRight])
        upperStackView.axis = .horizontal
        upperStackView.distribution = .fillEqually
        upperStackView.translatesAutoresizingMaskIntoConstraints = false
        let lowerStackView = UIStackView(arrangedSubviews: [buttonTankLeft, buttonForwardTank, buttonTankRight])
        lowerStackView.axis = .horizontal
        lowerStackView.distribution = .fillEqually
        lowerStackView.translatesAutoresizingMaskIntoConstraints = false
        let buttonsPanel = UIStackView(arrangedSubviews: [upperStackView, lowerStackView])
        buttonsPanel.axis = .vertical
        buttonsPanel.distribution = .fillEqually
        buttonsPanel.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(buttonsPanel)
        return buttonsPanel
    }()
    
    
    @IBOutlet weak var arView: ARView!
    
    var tankAnchor: TinyToyTank._TinyToyTank?
//    var terracotaCube: HelloRealityKit.TerracotaScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutConstraints()

        arView.debugOptions.insert(.showSceneUnderstanding)
        tankAnchor = try? TinyToyTank.load_TinyToyTank()


        guard let tankAnchor = tankAnchor else {
            fatalError("TankAnchor cube could not finish")
        }
        
        
        tankAnchor.cannon?.setParent(tankAnchor, preservingWorldTransform: true)
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(tankAnchor)
    }
    
//    fileprivate func createNode() -> SCN
    
    fileprivate func layoutConstraints() {
        NSLayoutConstraint.activate([
            buttonPanel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            buttonPanel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            buttonPanel.widthAnchor.constraint(equalToConstant: 270),
            buttonPanel.heightAnchor.constraint(equalToConstant: 180),
        ])
    }
}
