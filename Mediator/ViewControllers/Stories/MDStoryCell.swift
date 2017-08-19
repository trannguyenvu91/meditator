//
//  MDStoryCell.swift
//  Mediator
//
//  Created by VuVince on 8/19/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDStoryCell: UICollectionViewCell, MDModelViewProtocol {
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
    }
    
    func setup(with model: MDModelProtocol?) {
        //TODO: Set proper content
    }
    
}
