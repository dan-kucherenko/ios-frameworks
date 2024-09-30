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
    
    @StateObject private var videoPlayer = VideoPlayer.shared
    @State private var videoIsSaved: Bool = false

    var body: some View {
        ZStack {
            VideoPlayerView(customVideoPlayer: videoPlayer)
                    .ignoresSafeArea()
            VStack {
                Spacer()
                VideoControllersView(videoPlayer: self.videoPlayer)
                    .padding()
                    .background(BlurView(style: .regular))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            }
        }
        .onAppear {
            videoPlayer.setupPlayer(with: file)
        }
        .alert("Video has been saved", isPresented: $videoIsSaved) {
            Button("Ok") {
                videoIsSaved = false
            }
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
                print("Unknown error occurred while saving the video")
            }
        }
    }
}

#Preview {
    VideoDetailsView(
        file: URL(string: "asdasdas")!
    )
}
