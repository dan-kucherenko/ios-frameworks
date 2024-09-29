//
//  CameraFooterView.swift
//  CameraApp
//
//  Created by Daniil on 28.09.2024.
//

import SwiftUI

struct CameraFooterView: View {
    @State private var isVideoRecording = false
    
    var body: some View {
        HStack(spacing: 35) {
            photoCapturingButton
            videoRecordingButton
            changeCameraButton
        }
        .padding()
        .background(BlurView(style: .regular))
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}


extension CameraFooterView {
    @ViewBuilder
    private var photoCapturingButton: some View {
        Button {
            MediaRecordingManager.shared.takePhoto()
        } label: {
            Image(systemName: "camera.aperture")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(7)
        }
        .tint(.primary)
        .buttonStyle(.bordered)
        .clipShape(Circle())
    }
    
    @ViewBuilder
    private var videoRecordingButton: some View {
        Button {
            if !isVideoRecording {
                MediaRecordingManager.shared.startRecording()
            } else {
                MediaRecordingManager.shared.stopRecording()
            }
            isVideoRecording.toggle()
        } label: {
            Image(systemName: isVideoRecording ? "record.circle.fill" : "record.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(7)
        }
        .tint(.primary)
        .buttonStyle(.bordered)
        .clipShape(Circle())
    }
    
    @ViewBuilder
    private var changeCameraButton: some View {
        Button {
            print("Change camera")
            MediaRecordingManager.shared.changeCamera()
        } label: {
            Image(systemName: "arrow.triangle.2.circlepath.camera")
                .resizable()
                .frame(width: 38, height: 30)
                .scaledToFit()
                .padding(7)
        }
        .tint(.primary)
        .buttonStyle(.bordered)
        .clipShape(Circle())
        .opacity(isVideoRecording ? 0 : 1)
        .scaleEffect(isVideoRecording ? 0.5 : 1)
        .animation(.easeInOut(duration: 0.2), value: isVideoRecording)
    }
    
    private func changeCamera() {
        
    }
}

// MARK: - Utility struct for blur effect on settings view
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

#Preview {
    CameraFooterView()
}
