//
//  MDVideoProvider.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import RealmSwift

class MDVideoProvider: NSObject, MDListProviderProtocol {
    var updatesNotification: (([IndexPath], [IndexPath], [IndexPath]) -> Void)?
    var reloadNotification: (() -> Void)?
    var notificationToken: NotificationToken? = nil
    var data = MDDBManager.defaultManager.getMedias()
    
    override init() {
        super.init()
        observeChanges()
    }
    
    func observeChanges() {
        // Observe Results Notifications
        notificationToken = data.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self?.reloadNotification?()
                break
            case .update(_, let deletions, let insertions, let modifications):
                self?.updatesNotification?(deletions.map({ IndexPath(row: $0, section: 0) }),
                                           insertions.map({ IndexPath(row: $0, section: 0) }),
                                           modifications.map({ IndexPath(row: $0, section: 0) }))
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }
    
    func model(at indexPath: IndexPath) -> MDModelProtocol? {
        guard indexPath.row < data.count else {
            return nil
        }
        return data[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return data.count
    }
    
    deinit {
        notificationToken?.stop()
    }
    
}
