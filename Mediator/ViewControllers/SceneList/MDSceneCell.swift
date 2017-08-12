//
//  MDSceneCell.swift
//  Mediator
//
//  Created by VuVince on 8/12/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDSceneCell: UITableViewCell, MDModelViewProtocol {
    @IBOutlet weak var previewImageView: UIImageView!
    var media: MDMedia?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.clear
        previewImageView.layer.masksToBounds = true
        previewImageView.layer.cornerRadius = 6
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        previewImageView.alpha = highlighted ? 0.6 : 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        previewImageView.alpha = selected ? 0.6 : 1
    }
    
    func setup(with model: MDModelProtocol?) {
        guard let videoModel = model as? MDMedia else { return }
        media = videoModel
        previewImageView.image = videoModel.thumbImage
    }
}
