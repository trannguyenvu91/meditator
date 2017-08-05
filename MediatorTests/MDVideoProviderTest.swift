//
//  MDVideoProviderTest.swift
//  MediatorTests
//
//  Created by VuVince on 8/3/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import XCTest
@testable import Mediator

class MDVideoProviderTest: MDBaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testData() {
        let medias = MDDBManager.defaultManager.getMedias()
        let provider = MDVideoProvider()
        XCTAssert(medias.count == provider.numberOfItems(in: 0), "Number of models in provider must be equal!")
        
        if let lastMedia = medias.last {
            let insertMedia = lastMedia.clone()
            try! MDDBManager.defaultManager.write {
                MDDBManager.defaultManager.delete(lastMedia)
            }
            XCTAssert(medias.count == provider.numberOfItems(in: 0), "Media items must be updated after deletion!")
            
            try! MDDBManager.defaultManager.write {
                MDDBManager.defaultManager.add(insertMedia)
            }
            XCTAssert(medias.count == provider.numberOfItems(in: 0), "Media items must be updated after adding!")
        }
    }
    
}
