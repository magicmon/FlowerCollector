//
//  FlowerInfosCell.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 19..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit

class FlowerInfosCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 5.0, height: 15.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.13
        
        self.layer.masksToBounds = false
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}
