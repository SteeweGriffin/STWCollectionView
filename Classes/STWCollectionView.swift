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
    
    weak var delegateInsideCustom: STWCollectionViewDelegate?
    weak var delegateOutsideCustom: STWCollectionViewDelegate?
    weak var delegateOutsideDefault: UICollectionViewDelegate?
    
    
    // MARK: Common Methods UICollectionViewDelegate Proxy
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegateInsideCustom?.collectionView?(collectionView, didSelectItemAt: indexPath)
        delegateOutsideCustom?.collectionView?(collectionView, didSelectItemAt: indexPath)
        delegateOutsideDefault?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegateInsideCustom?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
        delegateOutsideCustom?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
        delegateOutsideDefault?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        delegateInsideCustom?.collectionView?(collectionView, didDeselectItemAt: indexPath)
        delegateOutsideCustom?.collectionView?(collectionView, didDeselectItemAt: indexPath)
        delegateOutsideDefault?.collectionView?(collectionView, didDeselectItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        delegateInsideCustom?.collectionView?(collectionView, didHighlightItemAt: indexPath)
        delegateOutsideCustom?.collectionView?(collectionView, didHighlightItemAt: indexPath)
        delegateOutsideDefault?.collectionView?(collectionView, didHighlightItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        delegateInsideCustom?.collectionView?(collectionView, didUnhighlightItemAt: indexPath)
        delegateOutsideCustom?.collectionView?(collectionView, didUnhighlightItemAt: indexPath)
        delegateOutsideDefault?.collectionView?(collectionView, didUnhighlightItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegateInsideCustom?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
        delegateOutsideCustom?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
        delegateOutsideDefault?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    }
    
    // MARK: Common Methods UIScrollViewDelegate Proxy
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegateInsideCustom?.scrollViewDidScroll?(scrollView)
        delegateOutsideCustom?.scrollViewDidScroll?(scrollView)
        delegateOutsideDefault?.scrollViewDidScroll?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegateInsideCustom?.scrollViewDidEndDecelerating?(scrollView)
        delegateOutsideCustom?.scrollViewDidEndDecelerating?(scrollView)
        delegateOutsideDefault?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegateInsideCustom?.scrollViewDidEndScrollingAnimation?(scrollView)
        delegateOutsideCustom?.scrollViewDidEndScrollingAnimation?(scrollView)
        delegateOutsideDefault?.scrollViewDidEndScrollingAnimation?(scrollView)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegateInsideCustom?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
        delegateOutsideCustom?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
        delegateOutsideDefault?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
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
    /// - Disabled if the STWCollectionView is in horizontal and has a fixedCellSize
    /// - default: 20
    
    public var verticalPadding:CGFloat = 20 {
        didSet {
            if fixedCellSize == nil || direction == .vertical { self.updateItemSize() }
        }
    }
    
    
    
    /// Distance of cells form left and right border
    /// - Disabled if the STWCollectionView is in vertical and has a fixedCellSize
    /// - default: 20
    
    public var horizontalPadding:CGFloat = 20 {
        didSet {
            if fixedCellSize == nil || direction == .horizontal { self.updateItemSize() }
        }
    }
    
    
    /// Distance beetween cells
    /// - default: 20
    
    public var itemSpacing:CGFloat = 20 {
        didSet { self.updateItemSize() }
    }
    
    
    /// Numbers of simultaneous visible cells
    /// - Sets fixedCellSize to nil when is setted
    /// - default: 1
    
    public var fixedCellsNumber:Int = 1 {
        didSet {
            if fixedCellSize == nil { self.updateItemSize() }
        }
    }
    
    
    /// Fixed size of cells
    /// - Disables fixedCellsNumber when is setted
    
    public var fixedCellSize:CGSize? {
        didSet { self.updateItemSize() }
    }
    
    /// Force the contentInset of STWCollectionView so that first and last items are centered
    /// - Work only with fixedCellSize setted
    
    public var forceCentered:Bool = false {
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
    /// - if fixedCellsNumber are even the result is a CGFloat beetween two value
    
    public private(set) var currentPage:CGFloat = 0
    
    /// Multicast delegate
    
    private var proxy = STWCollectionProxy()
    
    override var delegate: UICollectionViewDelegate? {
        get { return super.delegate }
        set{
            
            if let _ = newValue as? STWCollectionViewDelegate {
                self.proxy.delegateOutsideCustom = newValue as? STWCollectionViewDelegate
                self.proxy.delegateOutsideDefault = nil
            }else{
                self.proxy.delegateOutsideDefault = newValue
                self.proxy.delegateOutsideCustom = nil
            }
            
        }
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)
        self.proxy.delegateInsideCustom = self
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
     
     - if fixedCellsNumber is setted, calculates cells itemsSize
     - if fixedCellSize is setted, calculates fixedCellsNumber and directional padding
     
     */
    
    private func updateItemSize() {
        
        offsetHorizontalPadding = 0
        offsetVerticalPadding = 0
        
        var widthItem:CGFloat = 0
        var heightItem:CGFloat = 0
        
        if fixedCellSize != nil{
            
            switch direction {
                
            case .horizontal:
                
                verticalPadding = (self.bounds.size.height - fixedCellSize!.height)/2
                var tempfixedCellsNumber = (self.bounds.size.width - (horizontalPadding * 2) + itemSpacing) / (fixedCellSize!.width + itemSpacing)
                
                if tempfixedCellsNumber <= 1 { tempfixedCellsNumber = 1 }
                fixedCellsNumber = Int(floor(tempfixedCellsNumber))
                
                let preventWidth = (self.bounds.size.width - (horizontalPadding * 2) - ((itemSpacing) * CGFloat(fixedCellsNumber + 1))) / CGFloat(fixedCellsNumber)
                let difference =  preventWidth - fixedCellSize!.width
                offsetHorizontalPadding = difference * CGFloat(fixedCellsNumber)
                
                break
            case .vertical:
                
                horizontalPadding = (self.bounds.size.width - fixedCellSize!.width)/2
                var tempfixedCellsNumber = (self.bounds.size.height - (verticalPadding * 2) + itemSpacing) / (fixedCellSize!.height + itemSpacing)
                
                if tempfixedCellsNumber <= 1 { tempfixedCellsNumber = 1 }
                fixedCellsNumber = Int(floor(tempfixedCellsNumber))
                
                let preventHeight = (self.bounds.size.height - (verticalPadding * 2) - ((itemSpacing) * CGFloat(fixedCellsNumber + 1))) / CGFloat(fixedCellsNumber)
                let difference =  preventHeight - fixedCellSize!.height
                offsetVerticalPadding = difference * CGFloat(fixedCellsNumber)
                
                break
            }
            
            
        }
        
        switch direction {
            
        case .horizontal:
            widthItem = (self.bounds.size.width - (horizontalPadding * 2) - ((itemSpacing + offsetHorizontalPadding/CGFloat(fixedCellsNumber + 1)) * CGFloat(fixedCellsNumber + 1))) / CGFloat(fixedCellsNumber)
            heightItem = self.bounds.size.height - (verticalPadding * 2)
            break
        case .vertical:
            widthItem = self.bounds.size.width - (horizontalPadding * 2)
            heightItem = (self.bounds.size.height - (verticalPadding * 2) - ((itemSpacing + offsetVerticalPadding/CGFloat(fixedCellsNumber + 1)) * CGFloat(fixedCellsNumber + 1))) / CGFloat(fixedCellsNumber)
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
            
            if (difference - gap >= 1 && fixedCellsNumber%2 == 0 && gap < 0) { difference += 1 }
            
            newPoint.x -= (self.itemSize.width + itemSpacing) * CGFloat(Int(difference))
            
            
            break
        case .vertical:
            
            let stepPage:CGFloat = self.itemSize.height + itemSpacing
            
            let offset:CGFloat = (CGFloat(indexPath.item) * stepPage) - verticalPadding - itemSpacing - offsetVerticalPadding/2
            newPoint = CGPoint(x:0, y:offset)
            
            var difference = self.findCurrentPage(contentOffset: newPoint.y) - CGFloat(indexPath.item)
            let gap = self.findCurrentPage(contentOffset: self.contentOffset.y) - CGFloat(indexPath.item)
            
            if (difference - gap >= 1 && fixedCellsNumber%2 == 0 && gap < 0) { difference += 1 }
            
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
            let limitMax = self.contentSize.width - self.contentInset.right - (self.itemSize.width * CGFloat(fixedCellsNumber)) - (itemSpacing * CGFloat(fixedCellsNumber - 1))
            if newPoint.x < limitMin { resultNewPoint.x = limitMin }
            if newPoint.x > limitMax && limitMax > 0 { resultNewPoint.x = limitMax }
            
            break
        case .vertical:
            
            let limitMin = -self.contentInset.top
            let limitMax = self.contentSize.height - self.contentInset.bottom - (self.itemSize.height * CGFloat(fixedCellsNumber)) - (itemSpacing * CGFloat(fixedCellsNumber - 1))
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
     
     - returns a CGFloat because in case fixedCellsNumber are even, the center indexPath is in middle beetween two values
     
     - parameter contentOffset: offset of scroll
     
     */
    
    private func findCurrentPage(contentOffset:CGFloat) -> CGFloat {
        
        self.currentPage = 0
        
        switch direction {
        case .horizontal:
            
            let currentOffset = contentOffset + horizontalPadding + itemSpacing + offsetHorizontalPadding/2
            let currentSize = self.frame.size.width - horizontalPadding * 2 - (itemSpacing * CGFloat(fixedCellsNumber)) + (itemSpacing * CGFloat(fixedCellsNumber - 1)) - offsetHorizontalPadding
            self.currentPage = (currentOffset/currentSize*CGFloat(fixedCellsNumber)) + CGFloat((fixedCellsNumber - 1))/2
            
            break
        case .vertical:
            
            let currentOffset = contentOffset + verticalPadding + itemSpacing + offsetVerticalPadding/2
            let currentSize = self.frame.size.height - verticalPadding * 2 - (itemSpacing * CGFloat(fixedCellsNumber)) + (itemSpacing * CGFloat(fixedCellsNumber - 1)) - offsetVerticalPadding
            self.currentPage = (currentOffset/currentSize*CGFloat(fixedCellsNumber)) + CGFloat((fixedCellsNumber - 1))/2
            
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
        
        let countVisible = fixedCellsNumber + 2
        
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
            let offsetColumns = (fixedCellsNumber%2 == 0) ? 1 : 2
            let value = 1 - (difference / (CGFloat((fixedCellsNumber + offsetColumns)/2)))
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
            self.proxy.delegateOutsideCustom?.collectionViewDidScrollWithPercentages(self, visibleIndexPaths: self.currentVisibleIndexPaths, percentageVisibleIndexPaths: percentages)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            let percentages = self.calculatePercentages(scrollView: scrollView)
            self.proxy.delegateOutsideCustom?.collectionViewDidEndDeceleratingWithPercentages(self, visibleIndexPaths: self.currentVisibleIndexPaths, percentageVisibleIndexPaths: percentages)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            let percentages = self.calculatePercentages(scrollView: scrollView)
            self.proxy.delegateOutsideCustom?.collectionViewDidEndScrollingAnimationWithPercentages(self, visibleIndexPaths: self.currentVisibleIndexPaths, percentageVisibleIndexPaths: percentages)
        }
    }
    
}
