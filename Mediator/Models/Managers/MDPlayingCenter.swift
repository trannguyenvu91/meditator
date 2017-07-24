//
//  MDPlayingCenter.swift
//  Mediator
//
//  Created by VuVince on 7/4/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class MDPlayingCenter: NSObject {
    
    static let sharedInstance = MDPlayingCenter()
    
    override init() {
        super.init()
        loopPlayer()
        registerRemoteCommandCenter()
    }
    
    var media: MDMedia?
    var playerLayer: AVPlayerLayer?
    
    var player: AVPlayer? {
        willSet {
            if player != newValue {
                player?.pause()
            }
        }
        didSet {
            play()
        }
    }
    
    func update(_player: AVPlayer, at _layer: AVPlayerLayer, with _media: MDMedia?) {
        player = _player
        playerLayer = _layer
        media = _media
    }
    
    //MARK: Control functionalities
    func play() {
        player?.isMuted = true
        player?.play()
        updateNowPlayingCenter()
    }
    
    func pause() {
        player?.pause()
    }
    
    func loopPlayer() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            self.player?.seek(to: kCMTimeZero)
            self.player?.play()
        }
    }
    
}

//MARK: Application status callbacks

extension MDPlayingCenter {
    
    func didEnterBackground() {
        playerLayer?.player = nil
    }
    
    func willEnterForeground() {
        playerLayer?.player = player
        play()
    }
    
}

//MARK: Control Center and Background playing
extension MDPlayingCenter {
    
    func registerBackgroundPlaying() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error)
        }
    }
    
    func registerRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.play()
            return .success
        }
        commandCenter.dislikeCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            return .success
        }
        commandCenter.likeCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            return .success
        }
        commandCenter.pauseCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            self.pause()
            return .success
        }
        commandCenter.ratingCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            return .success
        }
        commandCenter.likeCommand.localizedTitle = "Thumb Up"
        commandCenter.dislikeCommand.localizedTitle = "Thumb Down"
    }
    
    func updateNowPlayingCenter() {
        let title = "Meditation"
        let info = MPNowPlayingInfoCenter.default()
        var playingInfo = [MPMediaItemPropertyTitle: title] as [String : Any]
        
        if let _media = media, let preview = UIImage(contentsOfFile: _media.getThumbURL().path) {
            playingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(image: preview)
        }
        
        info.nowPlayingInfo = playingInfo
    }
    
}
