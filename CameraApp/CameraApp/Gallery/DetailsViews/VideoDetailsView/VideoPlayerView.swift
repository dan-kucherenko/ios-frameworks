//
//  VideoPlayerView.swift
//  CameraApp
//
//  Created by Daniil on 30.09.2024.
//

import SwiftUI
import AVFoundation

struct VideoPlayerView: UIViewRepresentable {
    @ObservedObject var customVideoPlayer: VideoPlayer

    func makeUIView(context: Context) -> PlayerUIView {
        let view = PlayerUIView()
        view.playerLayer.player = customVideoPlayer.player
        view.playerLayer.videoGravity = .resizeAspectFill
        return view
    }

    func updateUIView(_ uiView: PlayerUIView, context: Context) {
        if uiView.playerLayer.player != customVideoPlayer.player {
            uiView.playerLayer.player = customVideoPlayer.player
        }
    }
}

class PlayerUIView: UIView {
    var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }

    override class var layerClass: AnyClass {
        AVPlayerLayer.self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
