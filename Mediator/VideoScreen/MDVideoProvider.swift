//
//  MDVideoProvider.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDVideoProvider: NSObject, MDListProviderProtocol {
    var data = MDDBManager.defaultManager.getMedias()
    
    func model(at indexPath: IndexPath) -> MDModelProtocol? {
        guard indexPath.row < data.count else {
            return nil
        }
        return data[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return data.count
    }
    
}

//MARK: Get Data
extension MDVideoProvider {
    
    
}

