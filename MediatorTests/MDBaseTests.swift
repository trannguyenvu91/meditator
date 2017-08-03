//
//  MDBaseTests.swift
//  MDBaseTests
//
//  Created by VuVince on 8/1/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Mediator

class MDBaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Prepare data base for tests
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        let medias = MDDBManager.defaultManager.getMedias()
        if medias.count == 0 {
            UserDefaults.standard.didImportSamples(false)
            try! MDMediaImporter.sharedInstance.loadMediaSamples()
        }
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
}
