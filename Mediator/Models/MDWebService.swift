//
//  MDWebService.swift
//  Mediator
//
//  Created by VuVince on 9/10/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

enum Result<T, U> where U: Error {
    case success(payload: T)
    case failure(U?)
}

class MDWebService: NSObject {
    
}
