//
//  UserDefaultsTest.swift
//  MediatorTests
//
//  Created by VuVince on 8/2/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import XCTest
@testable import Mediator

class UserDefaultsTest: MDBaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testImportedSamples() {
        let user = UserDefaults.standard
        user.didImportSamples(true)
        XCTAssert(user.hasImportedSamples(), "After imported successful, the value must be true")
        user.didImportSamples(false)
        XCTAssert(!user.hasImportedSamples(), "After imported failed, the value must be false")
    }
    
}
