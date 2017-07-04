//
//  MDVideoCell.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit
import AVFoundation

class MDVideoCell: UICollectionViewCell, MDModelViewProtocol {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videoPlayerView: MDPlayerView!
    
    func setup(with model: MDModel?) {
        guard let videoModel = model as? MDVideoModel else { return }
        imageView.image = UIImage(named: videoModel.filePath)
    }
    
}

extension MDVideoCell {
    func playVideo() {
        if let player = videoPlayerView.player, player.isPlaying() == true {
            return
        }
        if let path = Bundle.main.path(forResource: "IMG_0648", ofType: "m4v") {
            let playItem = AVPlayerItem(url: URL(fileURLWithPath: path))
            let avPlayer:AVPlayer = AVPlayer(playerItem: playItem)
            videoPlayerView.player = avPlayer
            MDPlayerCenter.sharedInstance.currentPlayer = avPlayer
        }
    }
}