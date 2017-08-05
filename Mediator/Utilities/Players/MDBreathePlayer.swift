//
//  MDBreathePlayer.swift
//  Mediator
//
//  Created by VuVince on 8/5/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import AVFoundation

class MDBreathePlayer: AVQueuePlayer {
    var currentState = BreathState.inhale
    let allStates: [BreathState] = [.inhale, .hold, .exhale]
    var audioItems: [AVPlayerItem]!
    
    override init() {
        super.init()
        audioItems = try! loadAudios()
    }
    
    func playAudio(for toState: BreathState) throws {
        removeAllItems()
        if let index = allStates.index(of: toState) {
            let item = audioItems[index]
            item.seek(to: kCMTimeZero)
            insert(item, after: nil)
            play()
        } else {
            print("Can not play this state!")
        }
    }
    
    func loadAudios() throws -> [AVPlayerItem] {
        var audios = [AVPlayerItem]()
        for state in allStates {
            if let url = state.getAudioURL() {
                let item = AVPlayerItem(url: url)
                audios.append(item)
            } else {
                print("Load audios failed!")
            }
        }
        return audios
    }
    
}
