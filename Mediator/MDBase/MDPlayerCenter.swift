//
//  MDPlayerCenter.swift
//  Mediator
//
//  Created by VuVince on 7/4/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import AVFoundation

class MDPlayerCenter: NSObject {
    
    static let sharedInstance = MDPlayerCenter()
    
    override init() {
        super.init()
        loopPlayer()
    }
    
    var playerLayer: AVPlayerLayer?
    
    var currentPlayer: AVPlayer? {
        willSet {
            if currentPlayer != newValue {
                currentPlayer?.pause()
                newValue?.play()
            }
        }
    }
    
    func play() {
        currentPlayer?.play()
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
