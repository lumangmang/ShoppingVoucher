//
//  Application.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/13.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

final class Application {
    
    static let `default` = Application()
    
    var window: UIWindow?
    
    let disposeBag = DisposeBag()
    
    fileprivate let provider = MoyaProvider<VoucherAPI>()
    
    public func presentInitialScreen(in window: UIWindow?) {
        
        guard let window = window else { return }
        
        self.window = window
        
        window.rootViewController = LaunchViewController()
    }
    
    private func presentFetureScreen() {
        
    }
    
    
    private func configNetworking() {
        
    }
    
    private func fetchRomoteData() {
        provider.rx.request(.loading).mapJSON().subscribe(onSuccess: { response in
            print(response)
        }) { error in
            print(error)
        }.disposed(by: disposeBag)
    }
}

