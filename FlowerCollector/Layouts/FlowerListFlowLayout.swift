//
//  FlowerListFlowLayout.swift
//  FlowerCollector
//
/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class FlowerListFlowLayout: UICollectionViewFlowLayout {
    
    var standardItemAlpha: CGFloat = 0.8
    var standardItemScale: CGFloat = 0.85
    
    var isSetup = false
    
    override func prepare() {
        super.prepare()
        if isSetup == false {
            setupCollectionView()
            isSetup = true
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var newAttributes = [UICollectionViewLayoutAttributes]()
        
        for itemAttributes in attributes! {
            let newItemAttributes = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            changeLayoutAttributes(newItemAttributes)
            
            newAttributes.append(newItemAttributes)
        }
        
        return newAttributes
    }

    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    func changeLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        let collectionCenter = collectionView!.frame.size.width / 2
        let offset = collectionView!.contentOffset.x
        let normalizedCenter = attributes.center.x - offset
        
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance)/maxDistance
        
        let alpha = ratio * (1 - self.standardItemAlpha) + self.standardItemAlpha
        let scale = ratio * (1 - self.standardItemScale) + self.standardItemScale
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(alpha * 10)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let layoutAttributes = self.layoutAttributesForElements(in: collectionView!.bounds)
        
        let center = collectionView!.bounds.size.width / 2
        let proposedContentOffsetCenterOrigin = proposedContentOffset.x + center
        
        let closest = layoutAttributes!.sorted { abs($0.center.x - proposedContentOffsetCenterOrigin) < abs($1.center.x - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
        let targetContentOffset = CGPoint(x: floor(closest.center.x - center), y: proposedContentOffset.y)
        
        return targetContentOffset
    }
    
    func setupCollectionView() {
        self.collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
        
        self.estimatedItemSize = CGSize(width: self.itemSize.width * self.standardItemScale,
                                          height: self.itemSize.height * self.standardItemScale)
        self.minimumLineSpacing = -flexibleWidth(10)
        
        let items = self.collectionView!.numberOfItems(inSection: 0)
        
        guard let collectionSize = collectionView?.bounds.size else { return }
        let xInset = (collectionSize.width - self.itemSize.width) / 2
//        let yInset = (collectionSize.height - self.itemSize.height) / 2
        self.sectionInset = UIEdgeInsetsMake(0, xInset, 0, xInset + (self.minimumLineSpacing * CGFloat(max(1, items) - 1)))
    }
}

extension FlowerListFlowLayout {
    func flexibleWidth(_ width: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width * (width / collectionView!.bounds.width)
    }
}
