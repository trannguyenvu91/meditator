//
//  MDStoriesListViewController.swift
//  Mediator
//
//  Created by VuVince on 8/19/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDStoriesListViewController: MDBaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = MDStoriesViewModel()
    var dataSource: MDCollectionViewDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBlurBackground()
        dataSource = MDCollectionViewDataSource(collectionView: collectionView, owner: self, dataProvider: viewModel.dataProvider)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnCloseDidClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MDStoriesListViewController: MDCollectionViewDataSourceProtocol {
    func collectionView(_ collectionView: UICollectionView, dequeueReusableCellAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemSizeAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: UIConstant.storiesRowHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: UIConstant.storiesHeaderStandardHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
    }
    
}
