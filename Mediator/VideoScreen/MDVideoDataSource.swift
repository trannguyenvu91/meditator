//
//  MDVideoDataSource.swift
//  Mediator
//
//  Created by VuVince on 7/9/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

protocol MDVideoDataSourceProtocol: MDCollectionViewDataSourceProtocol {
    
}

class MDVideoDataSource: MDCollectionViewDataSource {
    
    func playVideoOnVisibleCell() {
        let cell = videoCell(cell: collectionView.visibleCells.first)
        cell?.playVideo()
    }
    
    func videoCell(cell: UICollectionViewCell?) -> MDVideoCell? {
        if let videoCell = cell as? MDVideoCell {
            return videoCell
        }
        return nil
    }
    
}

//MARK: Get view controllers

extension MDVideoDataSource {
    
    @discardableResult func presentImagePickerVC(fromVC: UIViewController,
                              animated flag: Bool,
                              completion: (() -> Swift.Void)? = nil) -> UIImagePickerController {
        return MDMediaImporter.presentImagePickerVC(fromVC: fromVC, animated: flag, completion: completion)
    }
    
}

//MARK: Overiding Functions
extension MDVideoDataSource {
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        super.scrollViewDidEndDecelerating(scrollView)
        playVideoOnVisibleCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        if (MDPlayingCenter.sharedInstance.player == nil) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                self.playVideoOnVisibleCell()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        videoCell(cell: cell)?.didEndDisplaying()
    }
    
}
