//
//  InitialSplitViewController.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class InitialSplitViewController: LMTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func setupView() {
        super.setupView()
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }

}
