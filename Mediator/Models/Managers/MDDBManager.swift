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
    
    func add(_ object: Object) {
        realm.add(object)
    }
    
    func delete(_ object: Object) {
        realm.delete(object)
    }
    
    func write(_ block: (() throws -> Swift.Void)) throws {
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

extension MDDBManager {
    func getMedias() -> Results<MDMedia> {
        return realm.objects(MDMedia.self).sorted(byKeyPath: "importDate", ascending: true)
    }
}
