//
//  VideoDetailsView.swift
//  CameraApp
//
//  Created by Daniil on 29.09.2024.
//

import SwiftUI
import Photos

struct VideoDetailsView: View {
    let file: URL
    let videoFiles: [URL]?
    
    @StateObject private var videoPlayer = VideoPlayer.shared
    @State private var videoIsSaved = false
    @State private var isPlaying = false
    @State private var loadNextVideo = false
    @State private var loadPreviousVideo = false
    @State var currentIndex = 0

    var body: some View {
        ZStack {
            VideoPlayerView(customVideoPlayer: videoPlayer)
                    .ignoresSafeArea()
            VStack {
                Spacer()
                
                VideoControllersView(
                    isPlaying: $isPlaying,
                    videoPlayer: videoPlayer,
                    loadNextVideo: $loadNextVideo,
                    loadPreviousVideo: $loadPreviousVideo
                )
                .padding()
                .background(BlurView(style: .regular))
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
        }
        .onAppear {
            if let index = videoFiles?.firstIndex(of: file) {
                currentIndex = index
                videoPlayer.setupPlayer(with: file) {
                    loadNextVideo = true
                    isPlaying = false
                    videoPlayer.pause()
                }
            }
        }
        .alert("Video has been saved", isPresented: $videoIsSaved) {
            Button("Ok") {
                videoIsSaved = false
            }
        }
        .onChange(of: loadNextVideo) {
            if loadNextVideo {
                loadNextVideoFile()
            }
        }
        .onChange(of: loadPreviousVideo) {
            if loadPreviousVideo {
                loadPreviousVideoFile()
            }
        }
        .onDisappear {
            isPlaying = false
            videoPlayer.pause()
        }
        .navigationBarItems(trailing: saveButton)
    }
}

extension VideoDetailsView {
    private var saveButton: some View {
        Button {
            saveVideoToLibrary(file: file)
            videoIsSaved = true
        } label: {
            Image(systemName: "square.and.arrow.down")
                .resizable()
                .imageScale(.large)
        }
    }
    
    private func saveVideoToLibrary(file: URL) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: file)
        }) { saved, error in
            if saved {
                print("Video saved to gallery")
            } else if let error = error {
                print("Error saving video: \(error.localizedDescription)")
            } else {
                print("Unknown error")
            }
        }
    }
    
    private func loadNextVideoFile() {
        if let videoFiles = videoFiles, currentIndex < videoFiles.count - 1 {
            currentIndex += 1
            loadNewFile(file: videoFiles[currentIndex])
            loadNextVideo.toggle()
        }
    }
    
    private func loadPreviousVideoFile() {
        if let videoFiles = videoFiles, currentIndex > 0 {
            currentIndex -= 1
            loadNewFile(file: videoFiles[currentIndex])
            loadPreviousVideo.toggle()
        }
    }
    
    private func loadNewFile(file: URL) {
        videoPlayer.setNewFile(file: file) {
            loadNextVideo = true
            isPlaying = false
            videoPlayer.pause()
        }
        isPlaying = true
    }
}

#Preview {
    VideoDetailsView(
        file: URL(string: "asdasdas")!,
        videoFiles: []
    )
}
