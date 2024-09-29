//
//  VideoControllersView.swift
//  CameraApp
//
//  Created by Daniil on 29.09.2024.
//

import SwiftUI

struct VideoControllersView: View {
    @State var isPlaying = false
    @State var isMuted = false
    
    var videoPlayer: VideoPlayable?
    
    var body: some View {
        HStack(spacing: 10) {
            backwardBtnView
            playPauseBtnView
            nextTrackBtnView
            muteButtonView
        }
    }
}

extension VideoControllersView {
    private var backwardBtnView: some View {
        VideoPlayerButton(imageName: "backward.end.fill", size: .title2) {
//            videoPlayer?.setNewFile(file: <#T##URL#>)
        }
    }

    private var playPauseBtnView: some View {
        VideoPlayerButton(imageName: isPlaying ? "pause.fill" : "play.fill",
                          size: .largeTitle) {
            isPlaying ? videoPlayer?.pause() : videoPlayer?.play()
            isPlaying.toggle()
        }
    }

    private var nextTrackBtnView: some View {
        VideoPlayerButton(imageName: "forward.end.fill", size: .title2) {
            // Change track to next
        }
    }
    
    private var muteButtonView: some View {
        VideoPlayerButton(imageName: isMuted ? "speaker.slash.fill" : "speaker.fill", size: .title2) {
            videoPlayer?.setPlayerVolume()
            isMuted.toggle()
        }
    }
}

#Preview {
    VideoControllersView(
        isPlaying: false,
        isMuted: false
    )
}
