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
    
    private init() {}
    
    var isMuted: Bool {
        return player?.isMuted ?? false
    }

    func setupPlayer(with url: URL) {
        player = AVPlayer(url: url)
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
    
    func setNewFile(file: URL) {
        let item = AVPlayerItem(url: file)
        player?.replaceCurrentItem(with: item)
    }
}
