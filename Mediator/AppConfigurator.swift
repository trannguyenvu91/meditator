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
        MDPlayerCenter.sharedInstance.registerBackgroundPlaying()
    }
    
    func didEnterBackground() {
        MDPlayerCenter.sharedInstance.didEnterBackground()
    }
    
    func willEnterForeground() {
        MDPlayerCenter.sharedInstance.willEnterForeground()
    }
    
}
