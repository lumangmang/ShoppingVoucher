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

final class Application: NSObject {
    
    static let `default` = Application()
    
    var window: UIWindow?
    var provider: API?
    
    let navigator: Navigator
    let disposeBag = DisposeBag()
    
//    fileprivate let provider = MoyaProvider<VoucherAPI>()
    public func presentInitialScreen(in window: UIWindow?) {
        
        _updateProvider()
        
        guard let window = window, let provider = provider else { return }
        
        self.window = window
        
//        window.rootViewController = LaunchViewController()
        
        let viewModel = LMTabBarViewModel(provider: provider)
        self.navigator.show(segue: .tabs(viewModel: viewModel), sender: nil, transition: .root(in: window))
    }
    
    override init() {
        navigator = Navigator.default
        super.init()
        _updateProvider()
    }
    
    private func presentFetureScreen() {
        
    }
    
    private func configNetworking() {
        
    }
    
    private func fetchRomoteData() {
//        provider.rx.request(.loading).mapJSON().subscribe(onSuccess: { response in
//            print(response)
//        }) { error in
//            print(error)
//        }.disposed(by: disposeBag)
    }
    
    private func _updateProvider() {
        let REST = RESTfulAPI(provider: Networking.networking())
        provider = REST
    }
}

