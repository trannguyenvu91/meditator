//
//  MDSceneListViewModel.swift
//  Mediator
//
//  Created by VuVince on 8/12/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDSceneListViewModel: NSObject {
    lazy var dataProvider = MDVideoProvider()
    
    func canEditRowAt(_ indexPath: IndexPath) -> Bool {
        return true
    }
    
    func editActionsForRowAt(_ indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") {[weak self] (_, indexPath) in
            self?.deleteModel(at: indexPath)
        }
        return [delete]
    }
    
    func deleteModel(at indexPath: IndexPath) {
        //TODO: remove model from data base
        if let model = dataProvider.model(at: indexPath) as? MDMedia {
            try! MDDBManager.defaultManager.write {
                model.deleteAndCleanFiles()
                MDDBManager.defaultManager.delete(model)
            }
        }
    }
    
}
