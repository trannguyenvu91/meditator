//
//  MDVideoViewModel.swift
//  Mediator
//
//  Created by VuVince on 8/10/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDVideoViewModel: NSObject {
    lazy var dataProvider = MDVideoProvider()
    
    func getIndexPath(for media: MDMedia) -> IndexPath? {
        if let index = dataProvider.data.index(of: media) {
            return IndexPath(row: index, section: 0)
        }
        return nil
    }
    
}
