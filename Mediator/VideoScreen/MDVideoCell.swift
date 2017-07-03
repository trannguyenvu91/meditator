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
        print("video layer: \(videoPlayerView.layer)")
    }
    
}

extension MDVideoCell {
    func playVideo() {
        if let path = Bundle.main.path(forResource: "IMG_0648", ofType: "MOV") {
            let playItem = AVPlayerItem(url: URL(fileURLWithPath: path))
            let avPlayer:AVPlayer = AVPlayer(playerItem: playItem)
            videoPlayerView.player = avPlayer
            videoPlayerView.player?.play()
        }
    }
    
    func pauseVideo()  {
        videoPlayerView.player?.pause()
    }
}
