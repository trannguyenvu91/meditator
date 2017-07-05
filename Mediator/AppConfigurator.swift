//
//  AppConfigurator.swift
//  Mediator
//
//  Created by VuVince on 7/5/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import AVFoundation

final class AppConfigurator: NSObject {
    func didFinishLaunching() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error)
        }
    }
    
    func didEnterBackground() {
        MDPlayerCenter.sharedInstance.playerLayer?.player = nil
    }
    
    func willEnterForeground() {
        MDPlayerCenter.sharedInstance.playerLayer?.player = MDPlayerCenter.sharedInstance.currentPlayer
    }
    
}
