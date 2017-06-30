//
//  MDVideoModel.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDVideoModel: MDModel {
    var filePath: String!
    
    init(fileName: String) {
        super.init()
        filePath = fileName
    }
    
    
}
