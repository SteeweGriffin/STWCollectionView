//
//  STWCollectionViewFlowLayout.swift
//  STWCollectionView
//
//  Created by Steewe MacBook Pro on 02/05/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit

open class STWCollectionViewFlowLayout: UICollectionViewFlowLayout {

    open override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        
        super.invalidateLayout(with: context)
        
        guard let collectionView = collectionView as? STWCollectionView else { return }
        
        
        switch collectionView.direction {
            
        case .horizontal:
            let inset = collectionView.itemSpacing + collectionView.horizontalPadding + ((collectionView.forceCentered) ? collectionView.offsetHorizontalPadding/2 : 0)
            collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
            collectionView.contentOffset = CGPoint(x: -inset, y: 0)

            break
        case .vertical:
            let inset = collectionView.itemSpacing + collectionView.verticalPadding + ((collectionView.forceCentered) ? collectionView.offsetVerticalPadding/2 : 0)
            collectionView.contentInset = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
            collectionView.contentOffset = CGPoint(x: 0, y: -inset)

            break
        
        }
    }

    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        
        guard let collectionView = collectionView as? STWCollectionView else { return proposedContentOffset }
        
        let proposedRect = CGRect(origin: proposedContentOffset, size: collectionView.bounds.size)

        guard let layoutAttributes = layoutAttributesForElements(in: proposedRect) else { return proposedContentOffset }

        guard let closeRect = self.findCloseAttribute(layoutAttributes: layoutAttributes, proposedrect:proposedRect, collectionView: collectionView) else { return proposedContentOffset }

        var newPoint:CGPoint = closeRect.frame.origin
        
        switch collectionView.direction {
        case .horizontal:
            
            newPoint.x = closeRect.frame.origin.x - collectionView.horizontalPadding - collectionView.itemSpacing - collectionView.offsetHorizontalPadding/2
            
            let checkOffset = closeRect.center.x - (collectionView.itemSize.width + collectionView.itemSpacing) / 2 - collectionView.horizontalPadding - collectionView.offsetHorizontalPadding/2
            let offset = checkOffset - collectionView.contentOffset.x
        
            if (velocity.x < 0.0 && offset > 0.0) || (velocity.x > 0.0 && offset < 0.0) {
                let stepItem = collectionView.itemSize.width + collectionView.itemSpacing
                let itemOffset = velocity.x > 0 ? stepItem : -stepItem
                newPoint.x = newPoint.x + itemOffset
            }

            
            break
        case .vertical:
            
            newPoint.y = closeRect.frame.origin.y - collectionView.verticalPadding - collectionView.itemSpacing - collectionView.offsetVerticalPadding/2
            
            let checkOffset = closeRect.center.y - (collectionView.itemSize.height + collectionView.itemSpacing) / 2 - collectionView.verticalPadding - collectionView.offsetVerticalPadding/2
            let offset = checkOffset - collectionView.contentOffset.y
            
            if (velocity.y < 0.0 && offset > 0.0) || (velocity.y > 0.0 && offset < 0.0) {
                let stepItem = collectionView.itemSize.height + collectionView.itemSpacing
                let itemOffset = velocity.y > 0 ? stepItem : -stepItem
                newPoint.y = newPoint.y + itemOffset
            }

            
            break
        }
        
        
        return newPoint
    }
    
    /**
     
     Calculates closest rectange from proposed rectangle
     
     - parameter layoutAttributes: array of UICollectionViewLayoutAttributes
     - parameter proposedrect: propoesd rectangle
     - parameter collectionView: current STWCollectionView
     
     */
    
    private func findCloseAttribute(layoutAttributes:[UICollectionViewLayoutAttributes], proposedrect:CGRect, collectionView:STWCollectionView) -> UICollectionViewLayoutAttributes? {
        var closeAttribute:UICollectionViewLayoutAttributes?
        
        var offset:CGFloat = 0
        
        switch collectionView.direction {
        case .horizontal:
            offset = proposedrect.origin.x + (self.itemSize.width / 2) + (collectionView.itemSpacing) + collectionView.horizontalPadding + collectionView.offsetHorizontalPadding/2
            break
        case .vertical:
            offset = proposedrect.origin.y + (self.itemSize.height / 2) + (collectionView.itemSpacing) + collectionView.verticalPadding + collectionView.offsetVerticalPadding/2
            break
        }
        
        
        for attribute: UICollectionViewLayoutAttributes in layoutAttributes {
            
            guard closeAttribute != nil else {
                closeAttribute = attribute
                continue
            }
            
            switch collectionView.direction {
            case .horizontal:
                if fabs(attribute.center.x - offset) < fabs(closeAttribute!.center.x - offset) {
                    closeAttribute = attribute
                }
                break
            case .vertical:
                if fabs(attribute.center.y - offset) < fabs(closeAttribute!.center.y - offset) {
                    closeAttribute = attribute
                }

                break
            }
            
           
        }
        
        return closeAttribute
    }
    
}
