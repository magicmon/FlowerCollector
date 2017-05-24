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
    
    var item: FlowerListViewModelItem? {
        didSet {
            guard let item = item else { return }
            
            if let name = item.flowerList.name {
                flowerImage.image = UIImage.init(named: "\(name).jpg")
            } else {
                flowerTitle.textColor = .black
                flowerDescription.textColor = .black
            }
            
            flowerTitle.text = item.flowerList.title
            flowerDescription.text = item.flowerList.description
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        flowerImage.image = nil
        flowerTitle.text = ""
        flowerDescription.text = ""
    }
}


extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
