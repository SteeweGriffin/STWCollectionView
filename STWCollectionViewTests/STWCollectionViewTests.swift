//
//  STWCollectionViewTests.swift
//  STWCollectionViewTests
//
//  Created by Steewe MacBook Pro on 02/05/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import XCTest
@testable import STWCollectionView


class STWCollectionViewTests: XCTestCase {
    
    
    let collectionColumns  = STWCollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    let collectionFixedHorizontal  = STWCollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    let collectionFixedVertical  = STWCollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    let collectionFixedHorizontalShort  = STWCollectionView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    let collectionFixedVerticalShort  = STWCollectionView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    let defaultColumnsEven = 4
    let defaultColumnsOdd = 3
    let defaultHorizontalPadding:CGFloat = 10
    let defaultVerticalPadding:CGFloat = 10
    let defaultItemSpacing:CGFloat = 20
    let defaultFixedSize = CGSize(width: 100, height: 100)
    let defaultDirectionHorizontal:UICollectionViewScrollDirection = .horizontal
    let defaultDirectionVertical:UICollectionViewScrollDirection = .vertical
 
    
    override func setUp() {
        super.setUp()
       
        XCTAssertNotNil(collectionColumns.collectionViewLayout as? STWCollectionViewFlowLayout)
        XCTAssertNotNil(collectionFixedHorizontal.collectionViewLayout as? STWCollectionViewFlowLayout)
        XCTAssertNotNil(collectionFixedVertical.collectionViewLayout as? STWCollectionViewFlowLayout)
        XCTAssertNotNil(collectionFixedHorizontalShort.collectionViewLayout as? STWCollectionViewFlowLayout)
        XCTAssertNotNil(collectionFixedVerticalShort.collectionViewLayout as? STWCollectionViewFlowLayout)
        
        collectionColumns.columns = defaultColumnsEven
        collectionColumns.horizontalPadding = defaultHorizontalPadding
        collectionColumns.verticalPadding = defaultVerticalPadding
        collectionColumns.itemSpacing = defaultItemSpacing
        
        collectionFixedHorizontal.direction = defaultDirectionHorizontal
        collectionFixedHorizontal.horizontalPadding = defaultHorizontalPadding
        collectionFixedHorizontal.verticalPadding = defaultVerticalPadding
        collectionFixedHorizontal.itemSpacing = defaultItemSpacing
        collectionFixedHorizontal.fixedSize = defaultFixedSize
        
        collectionFixedVertical.direction = defaultDirectionVertical
        collectionFixedVertical.horizontalPadding = defaultHorizontalPadding
        collectionFixedVertical.verticalPadding = defaultVerticalPadding
        collectionFixedVertical.itemSpacing = defaultItemSpacing
        collectionFixedVertical.fixedSize = defaultFixedSize
        
        collectionFixedHorizontalShort.direction = defaultDirectionHorizontal
        collectionFixedHorizontalShort.horizontalPadding = defaultHorizontalPadding
        collectionFixedHorizontalShort.verticalPadding = defaultVerticalPadding
        collectionFixedHorizontalShort.itemSpacing = defaultItemSpacing
        collectionFixedHorizontalShort.fixedSize = defaultFixedSize
        
        collectionFixedVerticalShort.direction = defaultDirectionVertical
        collectionFixedVerticalShort.horizontalPadding = defaultHorizontalPadding
        collectionFixedVerticalShort.verticalPadding = defaultVerticalPadding
        collectionFixedVerticalShort.itemSpacing = defaultItemSpacing
        collectionFixedVerticalShort.fixedSize = defaultFixedSize

        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    
    
    func testUpdateItemSize() {
        
        XCTAssertEqual(collectionColumns.columns, defaultColumnsEven)
        XCTAssertEqual(collectionColumns.horizontalPadding, defaultHorizontalPadding)
        XCTAssertEqual(collectionColumns.verticalPadding, defaultVerticalPadding)
        XCTAssertEqual(collectionColumns.itemSpacing, defaultItemSpacing)
        XCTAssertEqual(collectionColumns.direction, defaultDirectionHorizontal)
        XCTAssertNil(collectionColumns.fixedSize)
        XCTAssertEqual(collectionColumns.offsetVerticalPadding, 0)
        XCTAssertEqual(collectionColumns.offsetHorizontalPadding, 0)
        XCTAssertNotNil(collectionColumns.itemSize)
        XCTAssertGreaterThanOrEqual(collectionColumns.columns, 1)
        
        collectionColumns.direction = .horizontal
        let resultWidthColumns = collectionColumns.bounds.size.width - collectionColumns.horizontalPadding*2 - (collectionColumns.itemSpacing * CGFloat(collectionColumns.columns + 1))
        XCTAssertEqual(collectionColumns.itemSize.width, resultWidthColumns/CGFloat(collectionColumns.columns))
        
        collectionColumns.direction = .vertical
        let resultHeightColumns = collectionColumns.bounds.size.height - collectionColumns.verticalPadding*2 - (collectionColumns.itemSpacing * CGFloat(collectionColumns.columns + 1))
        XCTAssertEqual(collectionColumns.itemSize.height, resultHeightColumns/CGFloat(collectionColumns.columns))

        collectionColumns.direction = defaultDirectionHorizontal
        collectionColumns.columns = defaultColumnsOdd
        XCTAssertEqual(collectionColumns.columns, defaultColumnsOdd)
        XCTAssertEqual(collectionColumns.horizontalPadding, defaultHorizontalPadding)
        XCTAssertEqual(collectionColumns.verticalPadding, defaultVerticalPadding)
        XCTAssertEqual(collectionColumns.itemSpacing, defaultItemSpacing)
        XCTAssertEqual(collectionColumns.direction, defaultDirectionHorizontal)
        XCTAssertNil(collectionColumns.fixedSize)
        XCTAssertEqual(collectionColumns.offsetVerticalPadding, 0)
        XCTAssertEqual(collectionColumns.offsetHorizontalPadding, 0)
        XCTAssertNotNil(collectionColumns.itemSize)
        XCTAssertGreaterThanOrEqual(collectionColumns.columns, 1)
        
        XCTAssertEqual(collectionFixedHorizontal.horizontalPadding, defaultHorizontalPadding)
        XCTAssertEqual(collectionFixedHorizontal.itemSpacing, defaultItemSpacing)
        XCTAssertEqual(collectionFixedHorizontal.fixedSize, defaultFixedSize)
        XCTAssertEqual(collectionFixedHorizontal.direction, defaultDirectionHorizontal)
        XCTAssertEqual(collectionFixedHorizontal.itemSize, collectionFixedHorizontal.fixedSize)
        XCTAssertEqual(collectionFixedHorizontal.offsetVerticalPadding, 0)
        XCTAssertNotNil(collectionFixedHorizontal.itemSize)
        XCTAssertGreaterThanOrEqual(collectionFixedHorizontal.columns, 1)
        
        XCTAssertEqual(collectionFixedVertical.verticalPadding, defaultVerticalPadding)
        XCTAssertEqual(collectionFixedVertical.itemSpacing, defaultItemSpacing)
        XCTAssertEqual(collectionFixedVertical.fixedSize, defaultFixedSize)
        XCTAssertEqual(collectionFixedVertical.direction, defaultDirectionVertical)
        XCTAssertEqual(collectionFixedVertical.itemSize, collectionFixedVertical.fixedSize)
        XCTAssertEqual(collectionFixedVertical.offsetHorizontalPadding, 0)
        XCTAssertNotNil(collectionFixedVertical.itemSize)
        XCTAssertGreaterThanOrEqual(collectionFixedVertical.columns, 1)
        
        XCTAssertEqual(collectionFixedHorizontalShort.horizontalPadding, defaultHorizontalPadding)
        XCTAssertEqual(collectionFixedHorizontalShort.itemSpacing, defaultItemSpacing)
        XCTAssertEqual(collectionFixedHorizontalShort.fixedSize, defaultFixedSize)
        XCTAssertEqual(collectionFixedHorizontalShort.direction, defaultDirectionHorizontal)
        XCTAssertEqual(collectionFixedHorizontalShort.itemSize, collectionFixedHorizontalShort.fixedSize)
        XCTAssertEqual(collectionFixedHorizontalShort.offsetVerticalPadding, 0)
        XCTAssertNotNil(collectionFixedHorizontalShort.itemSize)
        XCTAssertGreaterThanOrEqual(collectionFixedHorizontalShort.columns, 1)
        
        XCTAssertEqual(collectionFixedVerticalShort.verticalPadding, defaultVerticalPadding)
        XCTAssertEqual(collectionFixedVerticalShort.itemSpacing, defaultItemSpacing)
        XCTAssertEqual(collectionFixedVerticalShort.fixedSize, defaultFixedSize)
        XCTAssertEqual(collectionFixedVerticalShort.direction, defaultDirectionVertical)
        XCTAssertEqual(collectionFixedVerticalShort.itemSize, collectionFixedVerticalShort.fixedSize)
        XCTAssertEqual(collectionFixedVerticalShort.offsetHorizontalPadding, 0)
        XCTAssertNotNil(collectionFixedVerticalShort.itemSize)
        XCTAssertGreaterThanOrEqual(collectionFixedVerticalShort.columns, 1) 
        
    }
    
    func testScrollTo(){
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        
        collectionColumns.direction = defaultDirectionHorizontal
        
        collectionColumns.scrollTo(indexPath: firstIndexPath, animated: false)
        XCTAssertGreaterThanOrEqual(collectionColumns.contentOffset.x, -collectionColumns.contentInset.left)
        
        collectionColumns.direction = defaultDirectionVertical
        
        collectionColumns.scrollTo(indexPath: firstIndexPath, animated: false)
        XCTAssertGreaterThanOrEqual(collectionColumns.contentOffset.y, -collectionColumns.contentInset.top)
        
        collectionFixedHorizontal.scrollTo(indexPath: firstIndexPath, animated: false)
        XCTAssertGreaterThanOrEqual(collectionFixedHorizontal.contentOffset.x, -collectionFixedHorizontal.contentInset.left)
        
        collectionFixedVertical.scrollTo(indexPath: firstIndexPath, animated: false)
        XCTAssertGreaterThanOrEqual(collectionFixedVertical.contentOffset.y, -collectionFixedVertical.contentInset.top)
        
    }
}
