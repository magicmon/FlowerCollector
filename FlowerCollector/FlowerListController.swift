//
//  FlowerListController.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 15..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit

class FlowerListController: UICollectionViewController {
    
    fileprivate let viewModel = FlowerListViewModel()
    
    var currentCard: Int = 0
    
    override func loadView() {
        super.loadView()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


// MARK: UICollectionViewDataSource
extension FlowerListController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlowerListCell.identifier, for: indexPath) as! FlowerListCell
        cell.item = viewModel.items[indexPath.item]
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension FlowerListController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == currentCard {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FlowerInfosVC") as? FlowerInfosController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension FlowerListController {
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView?.collectionViewLayout as! FlowerListFlowLayout
        
        let cardSize = layout.itemSize.width + layout.minimumLineSpacing
        let offset = scrollView.contentOffset.x
        
        currentCard = Int(floor((offset - cardSize / 2) / cardSize) + 1)
    }
}



