//
//  CollectionViewCell.swift
//  STWCollectionView
//
//  Created by Steewe MacBook Pro on 16/05/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .green
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width:0, height:0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 10

        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.textAlignment = .center
        self.contentView.addSubview(self.label)
        self.contentView.addConstraint(NSLayoutConstraint(item: self.label, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.label, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        
        self.label.text = ""
    }
    
    
    func populate(_ string:String){
        self.prepareForReuse()
        self.label.text = string
    }
}
