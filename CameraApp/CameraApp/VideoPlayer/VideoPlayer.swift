//
//  VideoPlayer.swift
//  CameraApp
//
//  Created by Daniil on 29.09.2024.
//

import Foundation
import AVFoundation
 
class VideoPlayer: VideoPlayable, ObservableObject {
    static let shared = VideoPlayer()
    
    @Published var player: AVPlayer?

    private var playerItem: AVPlayerItem?
    private var onVideoFinish: (() -> Void)?
    
    private init() {}
    
    var isMuted: Bool {
        return player?.isMuted ?? false
    }
    
    func setupPlayer(with url: URL, videoHasFinishedCompletion: @escaping () -> Void) {
        playerItem = AVPlayerItem(url: url)
        if player == nil {
            player = AVPlayer(playerItem: playerItem)
        } else {
            player?.replaceCurrentItem(with: playerItem)
        }
        
        onVideoFinish = videoHasFinishedCompletion
        addPlayerItemEndObserver()
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func setPlayerVolume() {
        player?.isMuted.toggle()
    }
    
    func setNewFile(file: URL, videoHasFinishedCompletion: @escaping () -> Void) {
        removePlayerItemEndObserver()
        setupPlayer(with: file, videoHasFinishedCompletion: videoHasFinishedCompletion)
        play()
    }
    
    private func addPlayerItemEndObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(videoDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: playerItem
        )
    }
    
    private func removePlayerItemEndObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: .AVPlayerItemDidPlayToEndTime,
            object: playerItem
        )
    }
    
    @objc func videoDidFinishPlaying() {
        onVideoFinish?()
    }
}
