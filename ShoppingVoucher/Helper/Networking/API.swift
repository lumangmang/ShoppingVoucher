//
//  API.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/15.
//  Copyright © 2019 Mac. All rights reserved.
//

import RxSwift
import RxCocoa


protocol API {
    
    func fetchIndexData() -> Single<Any>
    
}
