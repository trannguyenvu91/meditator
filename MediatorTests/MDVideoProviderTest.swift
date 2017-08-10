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
    
    let medias = MDDBManager.defaultManager.getMedias()
    let provider = MDVideoProvider()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeletion() {
        XCTAssert(medias.count == provider.numberOfItems(in: 0), "Number of models in provider must be equal!")
        
        if let lastMedia = medias.last {
            let expectDeletion = expectation(description: "Provider must notify Deletion")
            provider.deleteItemsNotification = { indexPaths in
                XCTAssert(indexPaths.count == 1, "No more than 1 model is inserted")
                expectDeletion.fulfill()
            }
            try! MDDBManager.defaultManager.write {
                MDDBManager.defaultManager.delete(lastMedia)
            }
            XCTAssert(medias.count == provider.numberOfItems(in: 0), "Media items must be updated after deletion!")
            waitForExpectations(timeout: 2.0, handler: nil)
        }
    }
    
    func testInsertion() {
        XCTAssert(medias.count == provider.numberOfItems(in: 0), "Number of models in provider must be equal!")
        
        if let lastMedia = medias.last {
            let insertMedia = lastMedia.clone()
            let expectInsertion = expectation(description: "Provider must notify Insertion")
            provider.insertItemsNotification = { indexPaths in
                XCTAssert(indexPaths.count == 1, "No more than 1 model is inserted")
                expectInsertion.fulfill()
            }
            try! MDDBManager.defaultManager.write {
                MDDBManager.defaultManager.add(insertMedia)
            }
            XCTAssert(medias.count == provider.numberOfItems(in: 0), "Media items must be updated after adding!")
            waitForExpectations(timeout: 2.0, handler: nil)
            
        }
    }
}
