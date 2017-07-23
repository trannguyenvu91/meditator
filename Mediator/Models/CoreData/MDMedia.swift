//
//  MDMedia.swift
//  Mediator
//
//  Created by VuVince on 7/15/17.
//Copyright © 2017 VuVince. All rights reserved.
//

import Foundation
import RealmSwift

class MDMedia: Object, MDModelProtocol {
    @objc dynamic var id: Int = 0
    @objc dynamic var title = ""
    @objc dynamic var fileName = ""
    @objc dynamic var thumbName = ""
    @objc dynamic var importDate = Date()
    @objc dynamic var type: Int = 0
    
}

//MARK: Thumbnail and URL
extension MDMedia {
    func generateThumbName() {
        thumbName = (fileName.components(separatedBy: ".").first?.appending(".png"))!
    }
    
    func getVideoURL() -> URL {
        return MDMedia.getFolerURL().appendingPathComponent(fileName, isDirectory: true)
    }
    
    func getThumbURL() -> URL {
        return MDMedia.getFolerURL().appendingPathComponent(thumbName, isDirectory: true)
    }
    
    class func getFolderName() -> String {
        return "media"
    }
    
    class func getFolerURL() -> URL {
        return FileManager.getDocumentsDirectory().appendingPathComponent(MDMedia.getFolderName(), isDirectory: true)
    }
}
