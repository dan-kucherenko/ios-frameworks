//
//  VideoRecordingManager.swift
//  CameraApp
//
//  Created by Daniil on 28.09.2024.
//

import Foundation
import AVFoundation

enum CameraType {
    case back
    case front
    
    var sessionPosition: AVCaptureDevice.Position {
        switch self {
        case .back: return .back
        case .front: return .front
        }
    }
}

enum MediaType {
    case video(fileExtension: String)
    case photo(fileExtension: String)
    
    var rawValue: String {
        switch self {
        case .video: return "video"
        case .photo: return "photo"
        }
    }
    
    var fileExtension: String {
        switch self {
        case .video(let ext), .photo(let ext):
            return ext
        }
    }
}

final class MediaRecordingManager: NSObject {
    static let shared = MediaRecordingManager()
    
    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureMovieFileOutput()
    private let photoOutput = AVCapturePhotoOutput()
    private(set) var preview: AVCaptureVideoPreviewLayer?
    
    private var currentCamera: CameraType = .back
    private var isRecording = false
    
    private override init() {}
    
    func startSession(with camera: CameraType = .back) {
        configureSession(with: camera)
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
        }
    }
        
    // MARK: - Configure the session
    private func configureSession(with cameraType: CameraType) {
        captureSession.beginConfiguration()
        
        for input in captureSession.inputs {
            captureSession.removeInput(input)
        }
        
        addAudioInput()
        addVideoInput(with: cameraType)
        addOutputs()
        
        captureSession.commitConfiguration()
        
        updatePreviewLayer()
    }
    
    private func updatePreviewLayer() {
        if preview == nil {
            preview = AVCaptureVideoPreviewLayer(session: captureSession)
            preview?.videoGravity = .resizeAspectFill
        }
    }
    
    // MARK: - Taking photo
    func takePhoto() {
        guard captureSession.isRunning else { return }
        
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    // MARK: - Recording video part
    func startRecording() {
        guard captureSession.isRunning, !isRecording else { return }
        
        let fileUrl = generateFileName(for: .video(fileExtension: "mp4"))
        videoOutput.startRecording(to: fileUrl, recordingDelegate: self)
        isRecording = true
    }
    
    func stopRecording() {
        guard isRecording else { return }
        videoOutput.stopRecording()
        isRecording = false
    }
    
    func changeCamera() {
        if captureSession.isRunning {
            captureSession.stopRunning()
            currentCamera = currentCamera.sessionPosition == .back ? .front : .back
            self.startSession(with: self.currentCamera)
        }
        print("Camera changed to \(currentCamera)")
    }

    
    // MARK: - Add audio input to the recording session
    private func addAudioInput() {
        let audioDevice = AVCaptureDevice.default(for: .audio)
        guard let audioDevice else { return }
        
        do {
            let audioInput = try AVCaptureDeviceInput(device: audioDevice)
            
            if captureSession.canAddInput(audioInput) {
                captureSession.addInput(audioInput)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Add video input to the recording session
    private func addVideoInput(with cameraType: CameraType) {
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraType.sessionPosition)
        guard let videoDevice else { return }
        
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoDevice)
            
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Add outputs to the session for photo and video
    private func addOutputs() {
        if !captureSession.outputs.contains(photoOutput) {
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
            } else {
                print("Error: Unable to add photo output")
            }
        }
        
        if !captureSession.outputs.contains(videoOutput) {
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            } else {
                print("Error: Unable to add video output")
            }
        }
    }
    
    private func generateFileName(for type: MediaType) -> URL {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        let timestamp = formatter.string(from: Date())
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("\(type.rawValue)_\(timestamp).\(type.fileExtension)")
    }
}

extension MediaRecordingManager: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Recording failed: \(error)")
        } else {
            print("Recording finished successfully: \(outputFileURL)")
        }
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("Started recording to: \(fileURL)")
    }
}

// MARK: - AVCapturePhotoCaptureDelegate for handling photo output
extension MediaRecordingManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else {
            print("Error capturing photo: \(error))")
            return
        }
        
        let fileUrl = generateFileName(for: .photo(fileExtension: "jpg"))
        
        do {
            try imageData.write(to: fileUrl)
            print("Photo saved to: \(fileUrl)")
        } catch {
            print("Failed to save photo: \(error)")
        }
    }
}
