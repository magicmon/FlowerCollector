//
//  FlowerModel.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 24..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit

class FlowerList {
    var name: String?
    var title: String?
    var description: String?
    
    init(name: String?, title: String?, description: String?) {
        self.name = name
        self.title = title
        self.description = description
    }
    
    convenience init(dictionary: NSDictionary) {
        let name = dictionary["name"] as? String
        let title = dictionary["title"] as? String
        let description = dictionary["description"] as? String
        
        self.init(name: name, title: title, description: description)
    }
}
