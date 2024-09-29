//
//  CameraViewController.swift
//  CameraApp
//
//  Created by Daniil on 28.09.2024.
//

import UIKit
import SwiftUI

class CameraViewController: UIViewController {
    override func viewDidLoad() {
        print("View appeared")
        configureVideoPreviewLayer()
        configureSettingsView()
    }
    
    private func configureVideoPreviewLayer() {
        MediaRecordingManager.shared.startSession()
        
        if let previewLayer = MediaRecordingManager.shared.preview {
            previewLayer.removeFromSuperlayer()
        }
        guard let preview = MediaRecordingManager.shared.preview else { return }
        preview.frame = view.bounds
        view.layer.addSublayer(preview)
    }
    
    // MARK: - Configuring SwiftUI setting view
    private func configureSettingsView() {
        let settingsController = UIHostingController(rootView: CameraFooterView())
        addChild(settingsController)
        settingsController.didMove(toParent: self)
        
        guard let settingsView = settingsController.view else { return }
        settingsView.backgroundColor = .clear
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(settingsView)
        
        NSLayoutConstraint.activate([
            settingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}

#Preview {
    CameraViewController()
}
