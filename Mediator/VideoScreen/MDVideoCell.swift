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
        imageView.image = UIImage(contentsOfFile: videoModel.getThumbURL().path)
        videoPlayerView.isHidden = true
    }
    
}

//MARK: Functionalities
extension MDVideoCell {
    
    func playVideo() {
        if let player = videoPlayerView.player, player.isPlaying() == true {
            return
        }
        if let url = media?.getVideoURL() {
            let playItem = AVPlayerItem(url: url)
            let avPlayer:AVPlayer = AVPlayer(playerItem: playItem)
            videoPlayerView.player = avPlayer
            MDPlayingCenter.sharedInstance.update(_player: avPlayer,
                                                  at: videoPlayerView.playerLayer,
                                                  with: media)
            videoPlayerView.isHidden = false
        }
    }
    
    func didEndDisplaying() {
        videoPlayerView.isHidden = true
    }
    
}
