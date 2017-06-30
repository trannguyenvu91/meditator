//
//  MDCollectionViewDataSource.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

protocol MDDataSourceProtocol: NSObjectProtocol {
    func itemSize(at indexPath: IndexPath, with model:MDModel?) -> CGSize
}

class MDCollectionViewDataSource: NSObject {
    weak var collectionView: UICollectionView!
    weak var owner: MDDataSourceProtocol!
    weak var dataProvider: MDListProviderProtocol!
    var reusedCellID: String!
    
    init(collectionView: UICollectionView, owner: MDDataSourceProtocol, dataProvider: MDListProviderProtocol, reusedCellID: String) {
        super.init()
        self.collectionView = collectionView
        self.owner = owner
        self.dataProvider = dataProvider
        self.reusedCellID = reusedCellID
        setup()
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension MDCollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusedCellID, for: indexPath) as! UICollectionViewCell & MDModelViewProtocol
        let model = dataProvider.model(at: indexPath)
        cell.setup(with: model)
        return cell
    }
}

extension MDCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = dataProvider.model(at: indexPath)
        return owner.itemSize(at: indexPath, with: model)
    }
}
