//
//  FlowerViewModel.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 24..
//  Copyright © 2017년 magicmon. All rights reserved.
//
import UIKit

class FlowerListViewModel {
    var items = [FlowerListViewModelItem]()
    
    init() {
        guard let path = Bundle.main.path(forResource: "FlowerList_Data", ofType: "plist"), let dictArray = NSArray(contentsOfFile: path) else {
            return
        }
        
        for item in dictArray {
            let flowerItem = FlowerListViewModelItem(item: item as! NSDictionary)
            items.append(flowerItem)
        }
    }
}

class FlowerListViewModelItem {
    var flowerList: FlowerList
    
    init(item: NSDictionary) {
        self.flowerList = FlowerList(dictionary: item)
    }
}
