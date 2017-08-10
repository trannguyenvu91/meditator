//
//  MDListProvider.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

//MARK: MDListProviderProtocol
protocol MDListProviderProtocol: NSObjectProtocol {
    //Data source
    func model(at indexPath: IndexPath) -> MDModelProtocol?
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    //Notify changes
    var insertItemsNotification:((_ indexPaths:[IndexPath]) -> Void)? { set get }
    var deleteItemsNotification:((_ indexPaths:[IndexPath]) -> Void)? { set get }
    var reloadItemsNotification:((_ indexPaths:[IndexPath]) -> Void)? { set get }
    var reloadNotification:(() -> Void)? { set get }
}

//MARK: MDModelViewProtocol
protocol MDModelViewProtocol {
    func setup(with model:MDModelProtocol?)
}

//MARK:
protocol MDModelProtocol {
    
}

