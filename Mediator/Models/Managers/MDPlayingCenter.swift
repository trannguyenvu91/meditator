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
    
    var playerLayer: AVPlayerLayer?
    
    var currentPlayer: AVPlayer? {
        willSet {
            if currentPlayer != newValue {
                currentPlayer?.pause()
            }
        }
        didSet {
            play()
        }
    }
    
    //MARK: Control functionalities
    func play() {
        currentPlayer?.isMuted = true
        currentPlayer?.play()
        updateNowPlayingCenter(title: "Meditator", previewImage: #imageLiteral(resourceName: "123.jpg"))
    }
    
    func pause() {
        currentPlayer?.pause()
    }
    
    func loopPlayer() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            self.currentPlayer?.seek(to: kCMTimeZero)
            self.currentPlayer?.play()
        }
    }
    
}

//MARK: Application status callbacks

extension MDPlayingCenter {
    
    func didEnterBackground() {
        playerLayer?.player = nil
    }
    
    func willEnterForeground() {
        playerLayer?.player = currentPlayer
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
    
    func updateNowPlayingCenter(title: String, previewImage: UIImage?) {
        let info = MPNowPlayingInfoCenter.default()
        var playingInfo = [MPMediaItemPropertyTitle: title] as [String : Any]
        if let image = previewImage {
            playingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(image: image)
        }
        info.nowPlayingInfo = playingInfo
    }
    
}
