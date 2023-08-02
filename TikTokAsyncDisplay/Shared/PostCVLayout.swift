//
//  PostCVLayout.swift
//  TikTokAsyncDisplay
//
//  Created by RX on 8/2/23.
//

import UIKit
import AsyncDisplayKit

class PostCVLayout: UICollectionViewLayout {
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentHeight: CGFloat = 0
    var currentIndex: CGFloat = 0
    fileprivate var contentWidth: CGFloat {
        guard let collectionNode = collectionNode else {
            return 0
        }
        return collectionNode.bounds.width
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    var collectionNode: ASCollectionNode?
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepare() {
        // 1. Only calculate once
        guard let collectionNode = collectionNode else { return }
        cache.removeAll()
        contentHeight = 0
        var yOffset: CGFloat = 0
        
        // 2. Iterates through the list of items in the first section
        
        for item in 0 ..< collectionNode.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            let frame = CGRect(x: 0, y: yOffset, width: collectionNode.bounds.width, height: collectionNode.bounds.height)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            // 3. Updates the collection view content height
            contentHeight = max(contentHeight, frame.maxY)
            yOffset = yOffset + collectionNode.bounds.height
        }
    }
   
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionNode = collectionNode else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        let screenHeight = collectionNode.bounds.height
        let threshhold: CGFloat = collectionNode.bounds.height * 0.5//150
        let proposedY = proposedContentOffset.y
        if proposedY > screenHeight*CGFloat(currentIndex) + threshhold {
            currentIndex += 1
        } else if proposedY < screenHeight*CGFloat(currentIndex) - threshhold {
            currentIndex -= 1
        }
        return CGPoint(x: proposedContentOffset.x, y: screenHeight*currentIndex)
    }

}
