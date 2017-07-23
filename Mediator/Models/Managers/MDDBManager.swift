//
//  MDDBManager.swift
//  Mediator
//
//  Created by VuVince on 7/21/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class MDDBManager: NSObject {
    fileprivate let realm = try! Realm()
    static let defaultManager = MDDBManager()
    
    public func add(_ object: Object) {
        realm.add(object)
    }
    
    public func write(_ block: (() throws -> Swift.Void)) throws {
        do {
            try realm.write({
                do {
                    try block()
                } catch let error {
                    throw error
                }
            })
        } catch let error {
            throw error
        }
    }
}
