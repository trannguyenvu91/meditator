//
//  MSStoriesProvider.swift
//  Mediator
//
//  Created by VuVince on 8/19/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDStoriesProvider: NSObject, MDListProviderProtocol {
    
    var reloadNotification: (() -> Void)?
    var updatesNotification: (([IndexPath], [IndexPath], [IndexPath]) -> Void)?
    var stories = [MDStory]()
    
    override init() {
        super.init()
        setupData()
    }
    
    func model(at indexPath: IndexPath) -> MDModelProtocol? {
        return stories[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return stories.count
    }
    
    func setupData() {
        for _ in 0...20 {
            let story = MDStory()
            stories.append(story)
        }
        reloadNotification?()
    }
    
}
