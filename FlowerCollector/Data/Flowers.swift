//
//  Flowers.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 16..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit

class Flowers {
    var name: String
    var title: String
    var description: String
    
    init(name: String, title: String, description: String) {
        self.name = name
        self.title = title
        self.description = description
    }
    
    convenience init(dictionary: NSDictionary) {
        let name = dictionary["name"] as? String
        let title = dictionary["title"] as? String
        let description = dictionary["description"] as? String
        
        self.init(name: name!, title: title!, description: description!)
    }
    
    class func loadFlowers() -> [Flowers] {
        var flowers = [Flowers]()
        if let path = Bundle.main.path(forResource: "Flower_Data", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    let flower = Flowers(dictionary: item as! NSDictionary)
                    flowers.append(flower)
                }
            }
        }
        
        return flowers
    }
}
