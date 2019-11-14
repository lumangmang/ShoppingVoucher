//
//  LMTabBarItem.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import RAMAnimatedTabBarController

enum LMTabBarItem: Int {
    case index, brand, find, settings, login

    private func controller(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
        switch self {
        case .index:
            let indexviewController = LMIndexViewController(viewModel: viewModel, navigator: navigator)
            return LMNavigationController(rootViewController: indexviewController)
        case .brand:
            let brandviewController = LMBrandViewController(viewModel: viewModel, navigator: navigator)
            return LMNavigationController(rootViewController: brandviewController)
        case .find:
            let findviewController = LMFindViewController(viewModel: viewModel, navigator: navigator)
            return LMNavigationController(rootViewController: findviewController)
        case .settings:
            let settingviewController = LMSettingViewController(viewModel: viewModel, navigator: navigator)
            return LMNavigationController(rootViewController: settingviewController)
        case .login:
            let loginviewController = LMLoginViewController(viewModel: viewModel, navigator: navigator)
            return LMNavigationController(rootViewController: loginviewController)
        }
    }
    
    func fetchController(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
        let viewController = controller(with: viewModel, navigator: navigator)
        let item = RAMAnimatedTabBarItem(title: "Index", image: nil, tag: rawValue)
        item.animation = animation
        viewController.tabBarItem = item
        return viewController
    }
    
    var animation: RAMItemAnimation {
        var animation: RAMItemAnimation
        switch self {
        case .index: animation = RAMFlipLeftTransitionItemAnimations()
        case .brand: animation = RAMBounceAnimation()
        case .find: animation = RAMBounceAnimation()
        case .settings: animation = RAMRightRotationAnimation()
        case .login: animation = RAMBounceAnimation()
        }
        return animation
    }
}

class LMTabBarController: RAMAnimatedTabBarController, Navigatable {
    var viewModel: LMTabBarViewModel?
    var navigator: Navigator!
    
    init(viewModel: ViewModel?, navigator: Navigator) {
        self.viewModel = viewModel as? LMTabBarViewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        
        let input = LMTabBarViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.tabBarItems.drive(onNext: { [weak self] tabbarItem in
            if let strongSelf = self {
                let controllers = tabbarItem.map {
                    $0.fetchController(with: viewModel.viewModel(for: $0), navigator: strongSelf.navigator) }
                strongSelf.setViewControllers(controllers, animated: false)
            }
        }).disposed(by: rx.disposeBag)
    }
    
    func setupView() {
        hero.isEnabled = true
        tabBar.hero.id = "TabBarID"
        tabBar.isTranslucent = false
    }
}
