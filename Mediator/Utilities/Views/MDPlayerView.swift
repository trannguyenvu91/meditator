//
//  MDPlayerView.swift
//  Mediator
//
//  Created by VuVince on 7/1/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import AVFoundation

class MDPlayerView: UIView {
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer = AVPlayerLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
        backgroundColor = UIColor.clear
        playerLayer.backgroundColor = UIColor.clear.cgColor
        self.layer.addSublayer(playerLayer)
    }
}

extension AVPlayer {
    func isPlaying() -> Bool {
        return (rate != 0) && (error == nil)
    }
}
