//
//  UserDefaultExtension.swift
//  Mediator
//
//  Created by VuVince on 7/31/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import Foundation

extension UserDefaults {
    
    func hasImportedSamples() -> Bool {
        return UserDefaults.standard.bool(forKey: "ImportedSamples")
    }
    
    func didImportSamples(_ success: Bool) {
        UserDefaults.standard.set(success, forKey: "ImportedSamples")
        UserDefaults.standard.synchronize()
    }
    
}
