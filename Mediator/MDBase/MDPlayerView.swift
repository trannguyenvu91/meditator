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
    
    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
        self.layer.addSublayer(playerLayer)
    }
}
