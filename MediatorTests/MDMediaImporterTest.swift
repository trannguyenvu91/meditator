//
//  MDMediaImporterTest.swift
//  Mediator
//
//  Created by VuVince on 8/1/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import XCTest
@testable import Mediator

class MDMediaImporterTest: MDBaseTests {
    let fileURL: URL! = Bundle.main.url(forResource: "VideoTest", withExtension: "m4v")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVideoThumbnail() {
        do {
            _ = try MDMediaImporter.sharedInstance.getThumbnailFrom(videoURL: fileURL)
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    func testLoadSamples() {
        UserDefaults.standard.didImportSamples(false)
        let medias = MDDBManager.defaultManager.getMedias()
        let mediaCount = medias.count
        do {
            try MDMediaImporter.sharedInstance.loadMediaSamples()
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }
        XCTAssert(medias.count > mediaCount, "Samples must be added to DB!")
    }
    
}
