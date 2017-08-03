//
//  MDPlayingCenterTest.swift
//  MediatorTests
//
//  Created by VuVince on 8/2/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import XCTest
@testable import Mediator

class MDPlayingCenterTest: MDBaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRegisterBackgroundPlaying() {
        do {
            try MDPlayingCenter.sharedInstance.registerBackgroundPlaying()
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
}
