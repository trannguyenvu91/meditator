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
        FileManager.createMDDirectory()
        MDPlayingCenter.sharedInstance.registerBackgroundPlaying()
        MDMediaImporter.sharedInstance.loadMediaSamples()
    }
    
    func didEnterBackground() {
        MDPlayingCenter.sharedInstance.didEnterBackground()
    }
    
    func willEnterForeground() {
        MDPlayingCenter.sharedInstance.willEnterForeground()
    }
    
}
