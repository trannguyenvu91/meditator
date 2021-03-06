//
//  MDVideoCell.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import AVFoundation

//MARK: Setup views
class MDVideoCell: UICollectionViewCell, MDModelViewProtocol {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videoPlayerView: MDPlayerView!
    var media: MDMedia?
    
    func setup(with model: MDModelProtocol?) {
        guard let videoModel = model as? MDMedia else { return }
        media = videoModel
        imageView.image = videoModel.thumbImage
        videoPlayerView.isHidden = true
    }
    
}

//MARK: Functionalities
extension MDVideoCell {
    
    func playVideo() {
        if let _media = media {
            MDPlayingCenter.sharedInstance.play(_media, at: videoPlayerView.playerLayer)
            videoPlayerView.isHidden = false
        }
    }
    
    func didEndDisplaying() {
        videoPlayerView.isHidden = true
    }
    
}
