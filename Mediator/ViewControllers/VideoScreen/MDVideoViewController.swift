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
    var currentMedia: MDMedia?
    lazy var animator = MDSceneListAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = MDCollectionViewDataSource(collectionView: collectionView,
                                                owner: self,
                                                dataProvider: viewModel.dataProvider)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressImportBtn(_ sender: Any) {
        MDMediaImporter.presentImagePickerVC(fromVC: self, animated: true, completion: nil)
    }
    
}

//MARK: Navigation

extension MDVideoViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let identifier = segue.identifier else { return }
        segue.destination.transitioningDelegate = animator
        if identifier == "MDSceneListViewController",
            let scenesNavi = segue.destination as? UINavigationController,
            let scenesVC = scenesNavi.viewControllers.first as? MDSceneListViewController {
            scenesVC.delegate = self
        }
    }
    
}

//MARK: Data source delegate
extension MDVideoViewController: MDCollectionViewDataSourceProtocol {
    
    func collectionView(_ collectionView: UICollectionView, dequeueReusableCellAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemSizeAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (!MDPlayingCenter.sharedInstance.isPlaying()) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                self.playVideoOnVisibleCell()
            }
        } else if !AppConfigurator.isTopViewController(self) {
            videoCell(cell: cell)?.playVideo()
            currentMedia = videoCell(cell: cell)?.media
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        videoCell(cell: cell)?.didEndDisplaying()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        playVideoOnVisibleCell()
    }
    
    func playVideoOnVisibleCell() {
        var midOffset = collectionView.contentOffset
        midOffset.x += view.frame.width / 2.0;
        midOffset.y = collectionView.frame.height / 2.0
        if let indexPath = collectionView.indexPathForItem(at: midOffset), let cell = collectionView.cellForItem(at: indexPath) {
            videoCell(cell: cell)?.playVideo()
            currentMedia = videoCell(cell: cell)?.media
        }
    }
    
    func videoCell(cell: UICollectionViewCell?) -> MDVideoCell? {
        if let videoCell = cell as? MDVideoCell {
            return videoCell
        }
        return nil
    }
    
}

//MARK: MDSceneListViewControllerDelegate
extension MDVideoViewController: MDSceneListViewControllerDelegate {
    func getCurrentMedia() -> MDMedia? {
        return currentMedia
    }
    
    func play(media: MDMedia) {
        if let indexPath = viewModel.getIndexPath(for: media) {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            collectionView.setNeedsDisplay()
            playVideoOnVisibleCell()
        }
    }
    
}
