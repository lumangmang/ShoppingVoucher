//
//  KafkaRefresh+Ex.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/15.
//  Copyright © 2019 Mac. All rights reserved.
//

import RxCocoa
import RxSwift
import KafkaRefresh


extension Reactive where Base: KafkaRefreshControl {
    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { refreshControl, active in
            if active {
                
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
}
