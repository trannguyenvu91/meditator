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
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
