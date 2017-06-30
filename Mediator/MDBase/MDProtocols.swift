//
//  MDListProvider.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

protocol MDListProviderProtocol: NSObjectProtocol {
    var data: [MDModel] {
        get
    }
    func model(at indexPath: IndexPath) -> MDModel?
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
}

protocol MDModelViewProtocol {
    func setup(with model:MDModel?)
}


