//
//  ViewModel.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import RxCocoa
import RxSwift
import NSObject_Rx

let loggedIn = BehaviorRelay<Bool>(value: false)

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel: NSObject {
    
    let provider: API
    
    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
    
    let error = ErrorTracker()
    let parsedError = PublishSubject<APIError>()
    
    init(provider: API) {
        
        self.provider = provider
        
        super.init()
        
        error.asObservable().map { error -> APIError? in
            do {
                let errorResponse = error as? MoyaError
                if let body = try errorResponse?.response?.mapJSON() as? [String: Any] {
                    return APIError.serverError(response: errorResponse!)
                }
            } catch {
                print(error)
            }
            return nil
        }.filterEmpty().bind(to: parsedError).disposed(by: rx.disposeBag)
        
        error.asDriver().drive(onNext: { error in
            LogError("\(error)")
        }).disposed(by: rx.disposeBag)
    }
    
    deinit {
        LogDebug("\(type(of: self)): Deinited")
        LogResourcesCount()
    }
}
