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
    
    func viewModel(for tabbarItem: LMTabBarItem) -> ViewModel {
        switch tabbarItem {
        case .login:
            let viewModel = LoginViewModel()
            return viewModel
        default:
            return IndexViewModel()
        }
    }
}
