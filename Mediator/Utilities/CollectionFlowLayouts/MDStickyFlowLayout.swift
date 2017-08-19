//
//  MDStickyFlowLayout.swift
//  Mediator
//
//  Created by VuVince on 8/19/17.
//  Copyright © 2017 VuVince. All rights reserved.
//

import UIKit

class MDStickyFlowLayout: UICollectionViewFlowLayout {
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = super.layoutAttributesForElements(in: rect)
        
        if let headerAtt = attributes?.filter({$0.representedElementKind == UICollectionElementKindSectionHeader}).first {
            let _ = modifyHeader(attributes: headerAtt)
        } else if let headerAtt = layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: IndexPath(row: 0, section: 0)){
            attributes?.append(headerAtt)
        }
        return attributes
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else { return nil }
        return modifyHeader(attributes: attributes)
    }
    
    func modifyHeader(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let offsetY = collectionView?.contentOffset.y else { return attributes }
        let oldFrame = attributes.frame
        let headerHeight = offsetY > 0 ? max(oldFrame.height - offsetY, UIConstant.storiesHeaderMinHeight) : oldFrame.height - offsetY
        attributes.frame = CGRect(x: oldFrame.minX, y: offsetY, width: oldFrame.width, height: headerHeight)
        return attributes
    }
    
}
