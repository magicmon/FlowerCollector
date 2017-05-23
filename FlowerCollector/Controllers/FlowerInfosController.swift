//
//  FlowerInfosController.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 19..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FlowerInfosCell"

class FlowerInfosController: UICollectionViewController {
    
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func back() {
        _ = navigationController?.popViewController(animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension FlowerInfosController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FlowerInfosCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FlowerInfosSection", for: indexPath) as! FlowerInfosSectionHeader
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "FlowerDetailVC") as? FlowerDetailController {
            
            selectedIndexPath = indexPath
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
