//
//  UIConstant.swift
//  Mediator
//
//  Created by VuVince on 8/4/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

public struct UIConstant {
    //User defaults keys
    static let didImportMediaSamples = "ImportedSamples"
    
    //NSAutoLayout
    static let autoLayoutPriority_Required = 1000.0
    static let autoLayoutPriority_High = 750.0
    static let autoLayoutPriority_Low = 250.0
    
    //Breathe Animation
    static let indicatorAnimation = "indicatorAnimation"
    static let breathingAnimation = "breathingAnimation"
    static let progressAnimation = "progress"
    
    //Breathe titles
    static let breathing_Inhale = "Breathe in"
    static let breathing_exhale = "Breathe out"
    static let breathing_hold = "Hold"
    static let breathing_unknown = "Hmmmm"
    
    //Breathe audio files
    static let breathing_Inhale_file = "breathe_bubble_inhale"
    static let breathing_exhale_file = "breathe_bubble_exhale"
    static let breathing_hold_file = "breathe_bubble_pause"
    static let breathing_audio_extension = "wav"
    static let breathing_unknown_file = "meditation_bell"
    
    
}

func DEGREES_TO_RADIANS(_ degrees: Double) -> Double {
    return (.pi * degrees) / 90.0
}
