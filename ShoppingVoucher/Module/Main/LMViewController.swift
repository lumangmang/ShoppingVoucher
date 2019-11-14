//
//  LMViewController.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import NVActivityIndicatorView

class LMViewController: UIViewController, Navigatable {

    var viewModel: ViewModel?
    var navigator: Navigator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        view.backgroundColor = .white
    }
    
    init(viewModel: ViewModel?, navigator: Navigator) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
}
