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
    var dataSource: MDCollectionViewDataSource!
    let viewModel = MDVideoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = MDCollectionViewDataSource(collectionView: collectionView,
                                                owner: self,
                                                dataProvider: viewModel.dataProvider,
                                                reusedCellID: "Cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressImportBtn(_ sender: Any) {
        MDMediaImporter.presentImagePickerVC(fromVC: self, animated: true, completion: nil)
    }
    
}

//MARK: Data source delegate
extension MDVideoViewController: MDCollectionViewDataSourceProtocol {
    
    func itemSize(at indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        playVideoOnVisibleCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (!MDPlayingCenter.sharedInstance.isPlaying()) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                self.playVideoOnVisibleCell()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        videoCell(cell: cell)?.didEndDisplaying()
    }
    
    func playVideoOnVisibleCell() {
        var midOffset = collectionView.contentOffset
        midOffset.x += view.frame.width / 2.0;
        if let indexPath = collectionView.indexPathForItem(at: midOffset), let cell = collectionView.cellForItem(at: indexPath) {
            videoCell(cell: cell)?.playVideo()
        }
    }
    
    func videoCell(cell: UICollectionViewCell?) -> MDVideoCell? {
        if let videoCell = cell as? MDVideoCell {
            return videoCell
        }
        return nil
    }
    
}

