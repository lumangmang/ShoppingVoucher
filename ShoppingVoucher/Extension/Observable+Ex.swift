//
//  Observable+Ex.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import RxSwift


extension Observable where Element: Equatable {
    
    func ignore(value: Element) -> Observable<Element> {
        return filter { e -> Bool in
            return value != e
        }
    }
}

