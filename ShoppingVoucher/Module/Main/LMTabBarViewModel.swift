//
//  LMTabBarViewModel.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import RxSwift
import RxCocoa

class LMTabBarViewModel: ViewModel, ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let tabBarItems: Driver<[LMTabBarItem]>
    }

    func transform(input: LMTabBarViewModel.Input) -> LMTabBarViewModel.Output {
        let tabBarItems = loggedIn.map { login -> [LMTabBarItem] in
            if login {
                return [.index, .brand, .find, .settings]
            } else {
                return [.index, .brand, .find, .login]
            }
        }.asDriver(onErrorJustReturn: [])
        
        return Output(tabBarItems: tabBarItems)
    }
    
    override init(provider: API) {
        super.init(provider: provider)
    }
    
    func viewModel(for tabbarItem: LMTabBarItem) -> ViewModel {
        switch tabbarItem {
        case .login:
            let viewModel = LoginViewModel(provider: provider)
            return viewModel
        case .index:
            let viewModel = IndexViewModel(provider: provider)
            return viewModel
        case .brand:
            let viewModel = BrandViewModel(provider: provider)
            return viewModel
        case .find:
            let viewModel = FindViewModel(provider: provider)
            return viewModel
        case .settings:
            let viewModel = SettingViewModel(provider: provider)
            return viewModel
        }
    }
}
