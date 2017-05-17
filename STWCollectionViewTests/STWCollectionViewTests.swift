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
    
    let defaultColumns = 2
    let defaultHorizontalPadding:CGFloat = 10
    let defaultVerticalPadding:CGFloat = 10
    let defaultItemSpacing:CGFloat = 20
    let defaultFixedSize = CGSize(width: 100, height: 100)
    let defaultDirection:UICollectionViewScrollDirection = .horizontal
 
    
    override func setUp() {
        super.setUp()
       
        XCTAssertNotNil(collectionColumns.collectionViewLayout as? STWCollectionViewFlowLayout)
        XCTAssertNotNil(collectionFixedHorizontal.collectionViewLayout as? STWCollectionViewFlowLayout)
        XCTAssertNotNil(collectionFixedVertical.collectionViewLayout as? STWCollectionViewFlowLayout)
        
        collectionColumns.columns = defaultColumns
        collectionColumns.horizontalPadding = defaultHorizontalPadding
        collectionColumns.verticalPadding = defaultVerticalPadding
        collectionColumns.itemSpacing = defaultItemSpacing
        
        collectionFixedHorizontal.direction = .horizontal
        collectionFixedHorizontal.horizontalPadding = defaultHorizontalPadding
        collectionFixedHorizontal.verticalPadding = defaultVerticalPadding
        collectionFixedHorizontal.itemSpacing = defaultItemSpacing
        collectionFixedHorizontal.fixedSize = defaultFixedSize
        
        collectionFixedVertical.direction = .vertical
        collectionFixedVertical.horizontalPadding = defaultHorizontalPadding
        collectionFixedVertical.verticalPadding = defaultVerticalPadding
        collectionFixedVertical.itemSpacing = defaultItemSpacing
        collectionFixedVertical.fixedSize = defaultFixedSize
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    
    
    func testUpdateItemSize() {
        
        XCTAssertEqual(collectionColumns.columns, defaultColumns)
        XCTAssertEqual(collectionColumns.horizontalPadding, defaultHorizontalPadding)
        XCTAssertEqual(collectionColumns.verticalPadding, defaultVerticalPadding)
        XCTAssertEqual(collectionColumns.itemSpacing, defaultItemSpacing)
        XCTAssertEqual(collectionColumns.direction, defaultDirection)
        XCTAssertNil(collectionColumns.fixedSize)
        XCTAssertEqual(collectionColumns.offsetVerticalPadding, 0)
        XCTAssertEqual(collectionColumns.offsetHorizontalPadding, 0)
        XCTAssertNotNil(collectionColumns.itemSize)
        
        XCTAssertEqual(collectionFixedHorizontal.horizontalPadding, defaultHorizontalPadding)
        XCTAssertEqual(collectionFixedHorizontal.itemSpacing, defaultItemSpacing)
        XCTAssertEqual(collectionFixedHorizontal.fixedSize, defaultFixedSize)
        XCTAssertEqual(collectionFixedHorizontal.direction, .horizontal)
        XCTAssertEqual(collectionFixedHorizontal.itemSize, collectionFixedHorizontal.fixedSize)
        XCTAssertEqual(collectionFixedHorizontal.offsetVerticalPadding, 0)
        XCTAssertNotNil(collectionFixedHorizontal.itemSize)
        
        XCTAssertEqual(collectionFixedVertical.verticalPadding, defaultVerticalPadding)
        XCTAssertEqual(collectionFixedVertical.itemSpacing, defaultItemSpacing)
        XCTAssertEqual(collectionFixedVertical.fixedSize, defaultFixedSize)
        XCTAssertEqual(collectionFixedVertical.direction, .vertical)
        XCTAssertEqual(collectionFixedVertical.itemSize, collectionFixedVertical.fixedSize)
        XCTAssertEqual(collectionFixedVertical.offsetHorizontalPadding, 0)
        XCTAssertNotNil(collectionFixedVertical.itemSize)
        
            
        collectionColumns.direction = .horizontal
        let resultWidthColumns = collectionColumns.bounds.size.width - collectionColumns.horizontalPadding*2 - (collectionColumns.itemSpacing * CGFloat(collectionColumns.columns + 1))
        XCTAssertEqual(collectionColumns.itemSize.width, resultWidthColumns/CGFloat(collectionColumns.columns))
            
        collectionColumns.direction = .vertical
        let resultHeightColumns = collectionColumns.bounds.size.height - collectionColumns.verticalPadding*2 - (collectionColumns.itemSpacing * CGFloat(collectionColumns.columns + 1))
        XCTAssertEqual(collectionColumns.itemSize.height, resultHeightColumns/CGFloat(collectionColumns.columns))
            
        XCTAssertGreaterThanOrEqual(collectionFixedHorizontal.columns, 1)
        XCTAssertGreaterThanOrEqual(collectionFixedVertical.columns, 1)
        
    }
    
    func testScrollTo(){
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        
        collectionColumns.direction = .horizontal
        
        collectionColumns.scrollTo(indexPath: firstIndexPath, animated: false)
        XCTAssertGreaterThanOrEqual(collectionColumns.contentOffset.x, -collectionColumns.contentInset.left)
        
        collectionColumns.direction = .vertical
        
        collectionColumns.scrollTo(indexPath: firstIndexPath, animated: false)
        XCTAssertGreaterThanOrEqual(collectionColumns.contentOffset.y, -collectionColumns.contentInset.top)
        
        collectionFixedHorizontal.scrollTo(indexPath: firstIndexPath, animated: false)
        XCTAssertGreaterThanOrEqual(collectionFixedHorizontal.contentOffset.x, -collectionFixedHorizontal.contentInset.left)
        
        collectionFixedVertical.scrollTo(indexPath: firstIndexPath, animated: false)
        XCTAssertGreaterThanOrEqual(collectionFixedVertical.contentOffset.y, -collectionFixedVertical.contentInset.top)
        
    }
}
