//
//  MDVideoCell.swift
//  Mediator
//
//  Created by VuVince on 6/30/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDVideoCell: UICollectionViewCell, MDModelViewProtocol {
    @IBOutlet weak var imageView: UIImageView!
    
    func setup(with model: MDModel?) {
        guard let videoModel = model as? MDVideoModel else { return }
        imageView.image = UIImage(named: videoModel.filePath)
    }
}
