//
//  MDBreathCell.swift
//  Mediator
//
//  Created by VuVince on 9/19/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDBreathCell: UICollectionViewCell, MDModelViewProtocol {
    var breathView: UIBreathingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBreathView()
    }
    
    func setupBreathView() {
        breathView = UIBreathingView(frame: CGRect.zero,
                                     duration: 0,
                                     breathFragments: [],
                                     labelRatio: 0.8, labelColor: UIColor.blue)
        contentView.addSubview(breathView)
        breathView.snp.makeConstraints { (make) in
            make.center.equalTo(contentView.snp.center)
            make.width.equalTo(breathView.snp.height)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.6)
        }
    }
    
    func setup(with model: MDModelProtocol?) {
        guard let breathModel = model as? MDBreatheModel else { return; }
        breathView.updateBreath(fragments: breathModel.fragments)
    }
    
}
