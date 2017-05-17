//
//  FlowerListCell.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 15..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit

class FlowerListCell: UICollectionViewCell {
    @IBOutlet weak var flowerImage: UIImageView!
    @IBOutlet weak var flowerTitle: UILabel!
    @IBOutlet weak var flowerDescription: UILabel!
    
    var flower: Flowers? {
        didSet {
            if let theFlower = flower {
                flowerImage.image = UIImage.init(named: "\(theFlower.name).jpg")
                flowerTitle.text = theFlower.title
                flowerDescription.text = theFlower.description
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flowerImage.image = nil
        flowerTitle.text = ""
        flowerDescription.text = ""
    }
}
