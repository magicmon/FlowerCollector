//
//  FlowerListController.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 15..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FlowerListCell"

class FlowerListController: UICollectionViewController {
    
    let flowersData = Flowers.loadFlowers()
    
    var currentCard: Int = 0
    
    override func loadView() {
        super.loadView()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MasterToDetail" {
            let detailViewController = segue.destination as! FlowerInfoController
            detailViewController.title = "\(currentCard)"
//            detailViewController.character = sender as? Characters
        }
    }
}


// MARK: UICollectionViewDataSource
extension FlowerListController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flowersData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlowerListCell", for: indexPath) as! FlowerListCell
        cell.flower = flowersData[indexPath.item]
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension FlowerListController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == currentCard {
            performSegue(withIdentifier: "MasterToDetail", sender: nil)
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



