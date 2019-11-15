//
//  IndexViewModel.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import RxCocoa
import RxSwift

class IndexViewModel: ViewModel, ViewModelType {
   
    
    override init(provider: API) {
        super.init(provider: provider)
    }
    
    struct Input {
//        let headerRefresh: Observable<Void>
//        let footerRefresh: Observable<Void>
    }
    
    struct Output {
        
    }
    
    func transform(input: IndexViewModel.Input) -> IndexViewModel.Output {
        
        provider.fetchIndexData().trackActivity(loading).trackError(error)
        
        return Output()
    }
}
