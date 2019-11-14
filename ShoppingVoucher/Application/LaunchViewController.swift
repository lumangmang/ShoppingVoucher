//
//  LaunchViewController.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLaunchImageView()
        
//        fetchRomoteData()
    }
    
    private func fetchLaunchImageView() {
        let storyboard = UIStoryboard.init(name: "LaunchScreen", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        let launchView = viewController?.view
        launchView?.frame = (AppDelegate.shared?.window!.frame)!
        AppDelegate.shared?.window?.addSubview(launchView!)
    }
}
