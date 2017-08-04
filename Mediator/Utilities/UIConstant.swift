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
    
}

func DEGREES_TO_RADIANS(_ degrees: Double) -> Double {
    return (.pi * degrees) / 90.0
}
