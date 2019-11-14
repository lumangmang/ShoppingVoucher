//
//  Navigator.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Hero

protocol Navigatable {
    var navigator: Navigator! { get set }
}

class Navigator {

    static var `default` = Navigator()
    
    enum Scene {
        case tabs(viewModel: LMTabBarViewModel)
    }
    
    enum Transition {
        case root(in: UIWindow)
        case navigation(type: HeroDefaultAnimationType)
    }
    
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        switch transition {
        case .root(in: let window):
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = target
            }, completion: nil)
            return
        default: break
        }
        
        guard let sender = sender else {
                   fatalError("You need to pass in a sender for .navigation or .modal transitions")
               }
        if let navigationController = sender as? UINavigationController {
            navigationController.pushViewController(target, animated: false)
        }
        
        switch transition {
        case .navigation(let type):
            if let navigationController = sender.navigationController {
                navigationController.hero.navigationAnimationType = .autoReverse(presenting: type)
                navigationController.pushViewController(target, animated: true)
            }
        default:
            break
        }
    }
    
    func get(segue: Scene) -> UIViewController? {
        switch segue {
        case .tabs(let viewModel):
            let tabbarController = LMTabBarController(viewModel: viewModel, navigator: self)
            let splitViewController = InitialSplitViewController(viewModel: nil, navigator: self)
            let navigationController = LMNavigationController(rootViewController: splitViewController)
            let splitVC = SplitViewController()
            splitVC.viewControllers = [tabbarController, navigationController]
            return splitVC
        }
    }
}



