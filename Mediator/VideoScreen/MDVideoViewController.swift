//
//  MDVideoViewController.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDVideoViewController: MDBaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var videoProvider = MDVideoProvider()
    var dataSource: MDVideoDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = MDVideoDataSource(collectionView: collectionView,
                                                owner: self,
                                                dataProvider: videoProvider,
                                                reusedCellID: "Cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressImportBtn(_ sender: Any) {
        importMedia()
    }
    
}

//MARK: Navigations
extension MDVideoViewController {
    
    func importMedia() {
        dataSource.presentImagePickerVC(fromVC: self, animated: true, completion: nil)
    }
}

//MARK: MDDataSourceProtocol
extension MDVideoViewController: MDVideoDataSourceProtocol {
    
    func itemSize(at indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
}

