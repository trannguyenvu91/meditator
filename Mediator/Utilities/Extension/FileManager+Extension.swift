//
//  FileManager+Extension.swift
//  Mediator
//
//  Created by VuVince on 7/23/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

public extension FileManager {
    public class func createMDDirectory() throws {
        let directoryURL = MDMedia.getFolerURL()
        do {
            try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print(error.localizedDescription)
            throw error
        }
    }
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
