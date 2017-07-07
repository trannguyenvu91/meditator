//
//  MDVideoProvider.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDVideoProvider: NSObject, MDListProviderProtocol {
    
    var data: [MDModel] = MDVideoProvider.getVideoModels()
    
    func model(at indexPath: IndexPath) -> MDModel? {
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
    
    class func getVideoModels() -> [MDVideoModel] {
        var videoModels = [MDVideoModel]()
        if let filePath = Bundle.main.path(forResource: "VideoList", ofType: "plist"),
            let videoPaths:[String] = NSArray.init(contentsOf: URL(fileURLWithPath: filePath)) as? [String] {
            
            for videoPath in videoPaths {
                let model = MDVideoModel(fileName: videoPath)
                videoModels.append(model)
            }
        }
        return videoModels
    }
    
}

