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
        try! FileManager.createMDDirectory()
        try! MDPlayingCenter.sharedInstance.registerBackgroundPlaying()
        try! MDMediaImporter.sharedInstance.loadMediaSamples()
    }
    
    func didEnterBackground() {
        MDPlayingCenter.sharedInstance.didEnterBackground()
    }
    
    func willEnterForeground() {
        MDPlayingCenter.sharedInstance.willEnterForeground()
    }
    
    class func isTopViewController(_ vc: UIViewController) -> Bool {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController == vc
        }
        return false
    }
    
}
