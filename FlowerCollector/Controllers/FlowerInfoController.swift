//
//  FlowerInfoController.swift
//  FlowerCollector
//
//  Created by magicmon on 2017. 5. 16..
//  Copyright © 2017년 magicmon. All rights reserved.
//

import UIKit

class FlowerInfoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
