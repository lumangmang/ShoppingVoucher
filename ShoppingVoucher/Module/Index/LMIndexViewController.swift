//
//  LMIndexViewController.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LMIndexViewController: LMTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = viewModel as? IndexViewModel else { return }
        
        let input = IndexViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
    }
}
