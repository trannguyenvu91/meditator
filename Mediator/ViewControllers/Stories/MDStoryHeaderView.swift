//
//  MDStoryHeaderView.swift
//  Mediator
//
//  Created by VuVince on 8/19/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDStoryHeaderView: UICollectionReusableView {
    @IBOutlet weak var labelTitle: UILabel!
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let percentage = layoutAttributes.frame.height / UIConstant.storiesHeaderStandardHeight
        let scale = max(min(1, percentage), 0.5)
        labelTitle.transform = CGAffineTransform.init(scaleX: scale, y: scale)
    }
    
}
