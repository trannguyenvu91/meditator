//
//  MDVideoDataSource.swift
//  Mediator
//
//  Created by VuVince on 7/9/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import RealmSwift

protocol MDVideoDataSourceProtocol: MDCollectionViewDataSourceProtocol {
    
}

class MDVideoDataSource: MDCollectionViewDataSource {
    var notificationToken: NotificationToken? = nil
    
    override func setup() {
        super.setup()
        observeChanges()
    }
    
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
    
    func observeChanges() {
        // Observe Results Notifications
        guard let mediaProvider = dataProvider as? MDVideoProvider else { return }
        notificationToken = mediaProvider.data.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                self?.collectionView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                self?.collectionView.performBatchUpdates({
                    self?.collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                    self?.collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0) }))
                    self?.collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0)}))
                }, completion: nil)
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        }
    }
    
    deinit {
        notificationToken?.stop()
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
        if (!MDPlayingCenter.sharedInstance.isPlaying()) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                self.playVideoOnVisibleCell()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        videoCell(cell: cell)?.didEndDisplaying()
    }
    
}
