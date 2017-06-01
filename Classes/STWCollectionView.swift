//
//  STWCollectionView.swift
//  STWCollectionView
//
//  Created by Steewe MacBook Pro on 02/05/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit

/// Multicast Delegate

class STWCollectionProxy: NSObject, STWCollectionViewDelegate {
    
    weak var delegateInside: STWCollectionViewDelegate?
    weak var delegateOutside: STWCollectionViewDelegate?
    
    
    // MARK: Common Methods UICollectionViewDelegate Proxy
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegateInside?.collectionView?(collectionView, didSelectItemAt: indexPath)
        delegateOutside?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegateInside?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
        delegateOutside?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        delegateInside?.collectionView?(collectionView, didDeselectItemAt: indexPath)
        delegateOutside?.collectionView?(collectionView, didDeselectItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        delegateInside?.collectionView?(collectionView, didHighlightItemAt: indexPath)
        delegateOutside?.collectionView?(collectionView, didHighlightItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        delegateInside?.collectionView?(collectionView, didUnhighlightItemAt: indexPath)
        delegateOutside?.collectionView?(collectionView, didUnhighlightItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegateInside?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
        delegateOutside?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    }
    
    // MARK: Common Methods UIScrollViewDelegate Proxy
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegateInside?.scrollViewDidScroll?(scrollView)
        delegateOutside?.scrollViewDidScroll?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegateInside?.scrollViewDidEndDecelerating?(scrollView)
        delegateOutside?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegateInside?.scrollViewDidEndScrollingAnimation?(scrollView)
        delegateOutside?.scrollViewDidEndScrollingAnimation?(scrollView)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegateInside?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
        delegateOutside?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
}


/// STWCollectionViewDelegate extends UICollectionViewDelegate by adding method collectionViewDidScrollWithPercentages

protocol STWCollectionViewDelegate: UICollectionViewDelegate {
    
    /**
     
     Tells the delegate when the STWCollectionView scrolls
     
     - parameter collectionView: STWCollectionView object in which the scrolling occurred
     - parameter visibleIndexPaths: [IndexPath] contains the visible items' indexPaths
     - parameter percentageVisibleIndexPaths: [CGFloat] contains the the visible items' proximity percentages from STWCollectionView center
     
     */
    
    func collectionViewDidScrollWithPercentages(_ collectionView: STWCollectionView, visibleIndexPaths indexPaths:[IndexPath], percentageVisibleIndexPaths percentages:[CGFloat])
    
    /**
     
     Tells the delegate when the STWCollectionView did end decellerating
     
     - parameter collectionView: STWCollectionView object in which the scrolling occurred
     - parameter visibleIndexPaths: [IndexPath] contains the visible items' indexPaths
     - parameter percentageVisibleIndexPaths: [CGFloat] contains the the visible items' proximity percentages from STWCollectionView center
     
     */
    
    func collectionViewDidEndDeceleratingWithPercentages(_ collectionView: STWCollectionView, visibleIndexPaths indexPaths:[IndexPath], percentageVisibleIndexPaths percentages:[CGFloat])
    
    /**
     
     Tells the delegate when the STWCollectionView did end scrolling animation
     
     - parameter collectionView: STWCollectionView object in which the scrolling occurred
     - parameter visibleIndexPaths: [IndexPath] contains the visible items' indexPaths
     - parameter percentageVisibleIndexPaths: [CGFloat] contains the the visible items' proximity percentages from STWCollectionView center
     
     */
    
    func collectionViewDidEndScrollingAnimationWithPercentages(_ collectionView: STWCollectionView, visibleIndexPaths indexPaths:[IndexPath], percentageVisibleIndexPaths percentages:[CGFloat])
    
    
}

extension STWCollectionViewDelegate {
    
    func collectionViewDidScrollWithPercentages(_ collectionView: STWCollectionView, visibleIndexPaths indexPaths:[IndexPath], percentageVisibleIndexPaths percentages:[CGFloat]){}
    func collectionViewDidEndDeceleratingWithPercentages(_ collectionView: STWCollectionView, visibleIndexPaths indexPaths:[IndexPath], percentageVisibleIndexPaths percentages:[CGFloat]){}
    func collectionViewDidEndScrollingAnimationWithPercentages(_ collectionView: STWCollectionView, visibleIndexPaths indexPaths:[IndexPath], percentageVisibleIndexPaths percentages:[CGFloat]){}
    
}

class STWCollectionView: UICollectionView, STWCollectionViewDelegate  {
    
    private let layout:STWCollectionViewFlowLayout = STWCollectionViewFlowLayout()
    
    
    /// Distance of cells form top and bottom border
    /// - Disabled if the STWCollectionView is in horizontal and has a fixedSize
    /// - default: 20
    
    public var verticalPadding:CGFloat = 20 {
        didSet {
            if fixedSize == nil || direction == .vertical { self.updateItemSize() }
        }
    }
    
    
    
    /// Distance of cells form left and right border
    /// - Disabled if the STWCollectionView is in vertical and has a fixedSize
    /// - default: 20
    
    public var horizontalPadding:CGFloat = 20 {
        didSet {
            if fixedSize == nil || direction == .horizontal { self.updateItemSize() }
        }
    }
    
    
    /// Distance beetween cells
    /// - default: 20
    
    public var itemSpacing:CGFloat = 20 {
        didSet { self.updateItemSize() }
    }
    
    
    /// Numbers of simultaneous visible cells
    /// - Sets fixedSize to nil when is setted
    /// - default: 1
    
    public var columns:Int = 1 {
        didSet {
            if fixedSize == nil { self.updateItemSize() }
        }
    }
    
    
    /// Fixed size of cells
    /// - Disables columns when is setted
    
    public var fixedSize:CGSize? {
        didSet { self.updateItemSize() }
    }
    
    /// Direction of scrolling
    /// - default: .horizontal
    
    public var direction:UICollectionViewScrollDirection = .horizontal {
        didSet {
            layout.scrollDirection = direction
            self.updateItemSize()
        }
    }
    
    
    public private(set) var offsetHorizontalPadding:CGFloat = 0
    public private(set) var offsetVerticalPadding:CGFloat = 0
    
    /// Size cells
    
    public private(set) var itemSize:CGSize = CGSize.zero
    
    /// Contains current visible items' indexPaths
    
    public private(set) var currentVisibleIndexPaths = [IndexPath]()
    
    /// Current Index in center
    /// - if visible columns are even the result is a CGFloat beetween two value
    
    public private(set) var currentPage:CGFloat = 0
    
    /// Multicast delegate
    
    private var proxy = STWCollectionProxy()
    
    override var delegate: UICollectionViewDelegate? {
        get {
            return super.delegate
        }
        set{
            self.proxy.delegateOutside = newValue as? STWCollectionViewDelegate
        }
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)
        self.proxy.delegateInside = self
    }
    
    public init(frame: CGRect) {
        
        super.init(frame: frame, collectionViewLayout: layout)
        super.delegate = self.proxy
        self.decelerationRate = UIScrollViewDecelerationRateFast
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        layout.scrollDirection = direction
        
        self.updateItemSize()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = self.proxy
    }
    
    internal func deviceOrientationDidChange(){
        
        DispatchQueue.main.async {
            self.updateItemSize()
        }
    }
    
    /**
     
     Calculates flowlayout parameters
     
     - if columns is setted, calculates cells itemsSize
     - if fixedSize is setted, calculates columns and directional padding
     
     */
    
    private func updateItemSize() {
        
        offsetHorizontalPadding = 0
        offsetVerticalPadding = 0
        
        var widthItem:CGFloat = 0
        var heightItem:CGFloat = 0
        
        if fixedSize != nil{
            
            switch direction {
                
            case .horizontal:
                
                verticalPadding = (self.bounds.size.height - fixedSize!.height)/2
                var tempColumns = (self.bounds.size.width - (horizontalPadding * 2) + itemSpacing) / (fixedSize!.width + itemSpacing)
                
                if tempColumns <= 1 { tempColumns = 1 }
                columns = Int(floor(tempColumns))
                
                let preventWidth = (self.bounds.size.width - (horizontalPadding * 2) - ((itemSpacing) * CGFloat(columns + 1))) / CGFloat(columns)
                let difference =  preventWidth - fixedSize!.width
                offsetHorizontalPadding = difference * CGFloat(columns)
                
                break
            case .vertical:
                
                horizontalPadding = (self.bounds.size.width - fixedSize!.width)/2
                var tempColumns = (self.bounds.size.height - (verticalPadding * 2) + itemSpacing) / (fixedSize!.height + itemSpacing)
                
                if tempColumns <= 1 { tempColumns = 1 }
                columns = Int(floor(tempColumns))
                
                let preventHeight = (self.bounds.size.height - (verticalPadding * 2) - ((itemSpacing) * CGFloat(columns + 1))) / CGFloat(columns)
                let difference =  preventHeight - fixedSize!.height
                offsetVerticalPadding = difference * CGFloat(columns)
                
                break
            }
            
            
        }
        
        switch direction {
            
        case .horizontal:
            widthItem = (self.bounds.size.width - (horizontalPadding * 2) - ((itemSpacing + offsetHorizontalPadding/CGFloat(columns + 1)) * CGFloat(columns + 1))) / CGFloat(columns)
            heightItem = self.bounds.size.height - (verticalPadding * 2)
            break
        case .vertical:
            widthItem = self.bounds.size.width - (horizontalPadding * 2)
            heightItem = (self.bounds.size.height - (verticalPadding * 2) - ((itemSpacing + offsetVerticalPadding/CGFloat(columns + 1)) * CGFloat(columns + 1))) / CGFloat(columns)
            break
        }
        
        
        if  widthItem > 0 && heightItem > 0 {
            
            layout.invalidateLayout()
            layout.minimumLineSpacing = itemSpacing
            layout.minimumInteritemSpacing = (direction == .horizontal) ? self.bounds.size.height : self.bounds.size.width
            layout.itemSize = CGSize(width: widthItem, height: heightItem)
            self.itemSize = layout.itemSize
        }
    }
    
    /**
     
     Calculates offset Point for a paginated scroll
     
     - parameter indexPath: IndexPath of cell needs to view
     
     */
    
    private func calculateNewPoint(_ indexPath:IndexPath) -> CGPoint {
        
        var newPoint = CGPoint.zero
        
        switch direction {
        case .horizontal:
            
            let stepPage:CGFloat = self.itemSize.width + itemSpacing
            
            let offset:CGFloat = (CGFloat(indexPath.item) * stepPage) - horizontalPadding - itemSpacing - offsetHorizontalPadding/2
            newPoint = CGPoint(x:offset, y:0)
            
            var difference = self.findCurrentPage(contentOffset: newPoint.x) - CGFloat(indexPath.item)
            let gap = self.findCurrentPage(contentOffset: self.contentOffset.x) - CGFloat(indexPath.item)
            
            if (difference - gap >= 1 && columns%2 == 0 && gap < 0) { difference += 1 }
            
            newPoint.x -= (self.itemSize.width + itemSpacing) * CGFloat(Int(difference))
            
            
            break
        case .vertical:
            
            let stepPage:CGFloat = self.itemSize.height + itemSpacing
            
            let offset:CGFloat = (CGFloat(indexPath.item) * stepPage) - verticalPadding - itemSpacing - offsetVerticalPadding/2
            newPoint = CGPoint(x:0, y:offset)
            
            var difference = self.findCurrentPage(contentOffset: newPoint.y) - CGFloat(indexPath.item)
            let gap = self.findCurrentPage(contentOffset: self.contentOffset.y) - CGFloat(indexPath.item)
            
            if (difference - gap >= 1 && columns%2 == 0 && gap < 0) { difference += 1 }
            
            newPoint.y -= (self.itemSize.height + itemSpacing) * CGFloat(Int(difference))
            
            
            break
        }
        
        newPoint = self.normalizeNewPoint(newPoint)
        
        
        return newPoint
        
    }
    
    /**
     
     Adjusts offset Point for not rich minumum and maximum limits
     
     - parameter newPoint: offset Point calculated from indexPath
     
     */
    
    private func normalizeNewPoint(_ newPoint:CGPoint) -> CGPoint {
        var resultNewPoint = newPoint
        switch direction {
        case .horizontal:
            
            let limitMin = -self.contentInset.left
            let limitMax = self.contentSize.width - self.contentInset.right - (self.itemSize.width * CGFloat(columns)) - (itemSpacing * CGFloat(columns - 1))
            if newPoint.x < limitMin { resultNewPoint.x = limitMin }
            if newPoint.x > limitMax && limitMax > 0 { resultNewPoint.x = limitMax }
            
            break
        case .vertical:
            
            let limitMin = -self.contentInset.top
            let limitMax = self.contentSize.height - self.contentInset.bottom - (self.itemSize.height * CGFloat(columns)) - (itemSpacing * CGFloat(columns - 1))
            if newPoint.y < limitMin { resultNewPoint.y = limitMin }
            if newPoint.y > limitMax && limitMax > 0 { resultNewPoint.y = limitMax }
            
            break
        }
        
        
        return resultNewPoint
    }
    
    /**
     
     Scrolls STWCollectionView at indexPath
     
     - parameter indexPath: cell's IndexPath at scroll
     - parameter animated: scrolling is animated
     
     */
    
    public func scrollTo(indexPath:IndexPath, animated:Bool){
        self.setContentOffset(self.calculateNewPoint(indexPath), animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.itemSize != layout.itemSize {
            self.updateItemSize()
        }
    }
    
    /**
     
     Calculates current central visible cell's indexPath
     
     - returns a CGFloat because in case the columns visible are even, the center indexPath is in middle beetween two values
     
     - parameter contentOffset: offset of scroll
     
     */
    
    private func findCurrentPage(contentOffset:CGFloat) -> CGFloat {
        
        self.currentPage = 0
        
        switch direction {
        case .horizontal:
            
            let currentOffset = contentOffset + horizontalPadding + itemSpacing + offsetHorizontalPadding/2
            let currentSize = self.frame.size.width - horizontalPadding * 2 - (itemSpacing * CGFloat(columns)) + (itemSpacing * CGFloat(columns - 1)) - offsetHorizontalPadding
            self.currentPage = (currentOffset/currentSize*CGFloat(columns)) + CGFloat((columns - 1))/2
            
            break
        case .vertical:
            
            let currentOffset = contentOffset + verticalPadding + itemSpacing + offsetVerticalPadding/2
            let currentSize = self.frame.size.height - verticalPadding * 2 - (itemSpacing * CGFloat(columns)) + (itemSpacing * CGFloat(columns - 1)) - offsetVerticalPadding
            self.currentPage = (currentOffset/currentSize*CGFloat(columns)) + CGFloat((columns - 1))/2
            
            break
        }
        
        
        return self.currentPage
    }
    
    /**
     
     Update current current visible items' indexPaths
     
     - parameter currentPage: current central index page
     
     */
    
    
    private func updateCurrentVisibleIndexPaths(currentPage: CGFloat) {
        self.currentVisibleIndexPaths = [IndexPath]()
        
        let countVisible = columns + 2
        
        for i in 0..<countVisible{
            let offset = CGFloat( (countVisible%2 == 0) ? 0.5 : 0.0)
            let ceilCurrentPage = Int(round(currentPage + offset))
            let index = i + ceilCurrentPage - Int(countVisible/2)
            
            if index >= 0 && index < self.numberOfItems(inSection: 0) {
                let indexPath = IndexPath.init(item: index, section: 0)
                self.currentVisibleIndexPaths.append(indexPath)
            }
            
        }
        
    }
    
    /**
     
     Calculates array of visible cells percentages relative by center STWCollectionView
     
     - parameter currentPage: current central index page
     
     */
    
    private func findPercentageVisibleIndexPaths(currentPage: CGFloat) -> [CGFloat] {
        
        var result = [CGFloat]()
        
        for i in 0..<self.currentVisibleIndexPaths.count {
            let item = self.currentVisibleIndexPaths[i].item
            
            let difference = abs(CGFloat(item) - currentPage)
            let offsetColumns = (columns%2 == 0) ? 1 : 2
            let value = 1 - (difference / (CGFloat((columns + offsetColumns)/2)))
            var roundValue = (CGFloat(round(100*value)/100))
            if roundValue <= 0 { roundValue = 0 }
            if roundValue >= 1 { roundValue = 1 }
            result.append(roundValue)
        }
        
        return result
        
    }
    
    private func calculatePercentages(scrollView: UIScrollView) -> [CGFloat] {
        
        let currentPage = self.findCurrentPage(contentOffset: (direction == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y)
        self.updateCurrentVisibleIndexPaths(currentPage: currentPage)
        let percentages = self.findPercentageVisibleIndexPaths(currentPage: currentPage)
        
        return percentages
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            let percentages = self.calculatePercentages(scrollView: scrollView)
            self.proxy.delegateOutside?.collectionViewDidScrollWithPercentages(self, visibleIndexPaths: self.currentVisibleIndexPaths, percentageVisibleIndexPaths: percentages)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            let percentages = self.calculatePercentages(scrollView: scrollView)
            self.proxy.delegateOutside?.collectionViewDidEndDeceleratingWithPercentages(self, visibleIndexPaths: self.currentVisibleIndexPaths, percentageVisibleIndexPaths: percentages)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            let percentages = self.calculatePercentages(scrollView: scrollView)
            self.proxy.delegateOutside?.collectionViewDidEndScrollingAnimationWithPercentages(self, visibleIndexPaths: self.currentVisibleIndexPaths, percentageVisibleIndexPaths: percentages)
        }
    }
    
}
