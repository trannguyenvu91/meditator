//
//  MDMediaTest.swift
//  MediatorTests
//
//  Created by VuVince on 8/2/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import XCTest
@testable import Mediator

class MDMediaTest: MDBaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMediaURLs() {
        let medias = MDDBManager.defaultManager.getMedias()
        for media in medias {
            let videoURL = media.getVideoURL()
            let thumbURL = media.getThumbURL()
            if let audioURL = media.getAudioURL() {
                XCTAssert(FileManager.default.fileExists(atPath: audioURL.path), "Audio must be existed!")
            }
            XCTAssert(FileManager.default.fileExists(atPath: videoURL.path), "Video must be existed!")
            XCTAssert(FileManager.default.fileExists(atPath: thumbURL.path), "Thumb must be existed!")
        }
    }
    
}
