//
//  VideoControllersView.swift
//  CameraApp
//
//  Created by Daniil on 29.09.2024.
//

import SwiftUI

struct VideoControllersView: View {
    @Binding var isPlaying: Bool
    @State var isMuted = false
    
    var videoPlayer: VideoPlayable?
    
    @Binding var loadNextVideo: Bool
    @Binding var loadPreviousVideo: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            backwardBtnView
            playPauseBtnView
            nextTrackBtnView
            muteButtonView
        }
    }
}

extension VideoControllersView {
    private var backwardBtnView: some View {
        VideoPlayerButton(imageName: "backward.end.fill", size: .largeTitle) {
            loadPreviousVideo.toggle()
        }
    }
    
    private var playPauseBtnView: some View {
        VideoPlayerButton(imageName: isPlaying ? "pause.fill" : "play.fill",
                          size: .largeTitle) {
            isPlaying.toggle()
            isPlaying ? videoPlayer?.play() : videoPlayer?.pause()
        }
    }
    
    private var nextTrackBtnView: some View {
        VideoPlayerButton(imageName: "forward.end.fill", size: .largeTitle) {
            loadNextVideo.toggle()
        }
    }
    
    private var muteButtonView: some View {
        VideoPlayerButton(imageName: isMuted ? "speaker.slash.fill" : "speaker.fill", size: .largeTitle) {
            isMuted.toggle()
            videoPlayer?.setPlayerVolume()
        }
    }
}

#Preview {
    VideoControllersView(
        isPlaying: .constant(false),
        loadNextVideo: .constant(false),
        loadPreviousVideo: .constant(false)
    )
}
