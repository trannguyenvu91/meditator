//
//  MDVideoViewController.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDVideoViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var videoProvider = MDVideoProvider()
    var dataSource: MDCollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = MDCollectionViewDataSource(collectionView: collectionView,
                                                owner: self,
                                                dataProvider: videoProvider,
                                                reusedCellID: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MDVideoViewController: MDDataSourceProtocol {
    func itemSize(at indexPath: IndexPath, with model: MDModel?) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        videoCell(cell: cell)?.playVideo()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        videoCell(cell: cell)?.pauseVideo()
    }
    
    func videoCell(cell: UICollectionViewCell) -> MDVideoCell? {
        if let videoCell = cell as? MDVideoCell {
            return videoCell
        }
        return nil
    }
}

