//
//  VideoDetailsView.swift
//  CameraApp
//
//  Created by Daniil on 29.09.2024.
//

import SwiftUI
import AVFoundation

struct VideoDetailsView: View {
    let file: URL
    
    @StateObject private var videoPlayer = VideoPlayer.shared
    @State private var videoIsSaved: Bool = false

    var body: some View {
        VStack {
            VideoPlayerView(player: videoPlayer.player ?? AVPlayer())
                .frame(height: 300)
                
            VideoControllersView(videoPlayer: videoPlayer)
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
            //            saveToPhotoLibrary(file: file)
            videoIsSaved = true
        } label: {
            Image(systemName: "square.and.arrow.down")
                .resizable()
                .imageScale(.large)
        }
    }
}

#Preview {
    VideoDetailsView(
        file: URL(string: "asdasdas")!
    )
}
