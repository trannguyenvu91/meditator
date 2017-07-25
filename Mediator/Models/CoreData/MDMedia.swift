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
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var fileName = ""
    @objc dynamic var thumbName = ""
    @objc dynamic var importDate = Date()
    @objc dynamic var type: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
        
    }
    
    override static func indexedProperties() -> [String] {
        return ["importDate"]
    }
}

//MARK: Thumbnail and URLs
extension MDMedia {
    func generatePaths(from fileURL: URL) {
        id = UUID().uuidString
        let fileExtension = fileURL.pathComponents.last?.components(separatedBy: ".").last
        fileName = id.appending(".\(fileExtension!)")
        thumbName = id.appending(".png")
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
