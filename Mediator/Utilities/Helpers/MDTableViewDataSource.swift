//
//  MDTableViewDataSource.swift
//  Mediator
//
//  Created by VuVince on 8/12/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

@objc protocol MDTableViewDataSourceProtocol: NSObjectProtocol {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    @objc optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    @objc optional func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    @objc optional func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    @objc optional func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    @objc optional func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
}

class MDTableViewDataSource: NSObject {
    weak var tableView: UITableView!
    weak var owner: MDTableViewDataSourceProtocol!
    weak var dataProvider: MDListProviderProtocol!
    var reusedCellID: String!
    
    init(tableView: UITableView, owner: MDTableViewDataSourceProtocol, dataProvider: MDListProviderProtocol, reusedCellID: String) {
        super.init()
        self.tableView = tableView
        self.owner = owner
        self.dataProvider = dataProvider
        self.reusedCellID = reusedCellID
        setup()
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        dataProvider.updatesNotification = {[weak self] deletions, insertions, modifications in
            if #available(iOS 11.0, *) {
                self?.tableView.performBatchUpdates({[weak self] in
                    self?.tableView.insertRows(at: insertions, with: .top)
                    self?.tableView.deleteRows(at: deletions, with: .middle)
                    self?.tableView.reloadRows(at: modifications, with: .fade)
                    }, completion: nil)
            } else {
                // Fallback on earlier versions
                self?.tableView.beginUpdates()
                self?.tableView.insertRows(at: insertions, with: .top)
                self?.tableView.deleteRows(at: deletions, with: .middle)
                self?.tableView.reloadRows(at: modifications, with: .fade)
                self?.tableView.endUpdates()
            }
        }
        dataProvider.reloadNotification = {[weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

extension MDTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        owner.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        owner.tableView?(tableView, didDeselectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let canEdit = owner.tableView?(tableView, canEditRowAt:indexPath) {
            return canEdit
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return owner.tableView?(tableView, editActionsForRowAt:indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        owner.tableView?(tableView, commit: editingStyle, forRowAt: indexPath)
    }
    
}

extension MDTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return owner.tableView(tableView, heightForRowAt:indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusedCellID) as! UITableViewCell & MDModelViewProtocol
        let model = dataProvider.model(at: indexPath)
        cell.setup(with: model)
        return cell
    }
    
}

