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
        
//        let navigationTitle: Driver<String>
    }
    
    func transform(input: IndexViewModel.Input) -> IndexViewModel.Output {
        
//        let navigationTitle =
        
        provider.fetchIndexData().subscribe(onSuccess: {
            print($0)
        }) {
            print($0)
        }
        
        return Output()
    }
}
