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
    
    var currentPlayer: AVPlayer? {
        willSet {
            if currentPlayer != newValue {
                currentPlayer?.pause()
                newValue?.play()
            }
        }
    }
}
