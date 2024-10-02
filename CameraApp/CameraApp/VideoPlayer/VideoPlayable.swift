//
//  VideoPlayable.swift
//  CameraApp
//
//  Created by Daniil on 29.09.2024.
//

import Foundation

protocol VideoPlayable {
    var isMuted: Bool { get }

    func setupPlayer(with url: URL, videoHasFinishedCompletion: @escaping () -> Void)
    func play()
    func pause()
    func setPlayerVolume()
    func setNewFile(file: URL, videoHasFinishedCompletion: @escaping () -> Void)
    func videoDidFinishPlaying()
}
