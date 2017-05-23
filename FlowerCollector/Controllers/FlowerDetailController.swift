//
//  FlowerDetailController.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 19..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit

class FlowerDetailController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headerView.backgroundColor = .cyan
        self.view.backgroundColor = .cyan
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        _ = navigationController?.popViewController(animated: true)
    }
}
