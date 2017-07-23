//
//  MDCollectionViewDataSource.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

@objc protocol MDCollectionViewDataSourceProtocol: NSObjectProtocol {
    func itemSize(at indexPath: IndexPath, with model:MDModel?) -> CGSize
    @objc optional func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    @objc optional func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    @objc optional func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    @objc optional func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    @objc optional func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
}

//MARK: Initialization
class MDCollectionViewDataSource: NSObject {
    weak var collectionView: UICollectionView!
    weak var owner: MDCollectionViewDataSourceProtocol!
    weak var dataProvider: MDListProviderProtocol!
    var reusedCellID: String!
    
    init(collectionView: UICollectionView, owner: MDCollectionViewDataSourceProtocol, dataProvider: MDListProviderProtocol, reusedCellID: String) {
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

//MARK: UICollectionViewDataSource
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

//MARK: UICollectionViewDelegateFlowLayout
extension MDCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = dataProvider.model(at: indexPath)
        return owner.itemSize(at: indexPath, with: model)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        owner.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        owner.collectionView?(collectionView, didDeselectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        owner.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        owner.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        owner.scrollViewDidEndDecelerating?(scrollView)
    }
}