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
import HMSegmentedControl

enum IndexSegments {
    case rece, performed
    
    var title: String {
        switch self {
        case .rece:
            return "deji"
        case .performed: return "fdafa"
        }
    }
}

class LMIndexViewController: LMTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupView() {
        super.setupView()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = viewModel as? IndexViewModel else { return }
        
        let input = IndexViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
    }
    
    lazy var segmentedControl: HMSegmentedControl = {
        let items = [IndexSegments.rece.title, IndexSegments.performed.title]
        let segmentedControl = HMSegmentedControl(sectionTitles: items)
        segmentedControl?.selectedSegmentIndex = 0
        return segmentedControl!
    }()
}
