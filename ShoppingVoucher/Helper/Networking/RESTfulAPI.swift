//
//  RESTfulAPI.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/15.
//  Copyright © 2019 Mac. All rights reserved.
//

import Moya
import RxCocoa
import RxSwift

typealias MoyaError = Moya.MoyaError

enum APIError: Error {
    case serverError(response: MoyaError)
}


class RESTfulAPI: API {
    
    let provider: Networking
    
    init(provider: Networking) {
        self.provider = provider
    }
}


extension RESTfulAPI {
    func fetchIndexData() -> Single<Any> {
        return request(.loading)
    }
}

extension RESTfulAPI {
    private func request(_ target: VoucherAPI) -> Single<Any> {
        return provider.request(target).mapJSON().observeOn(MainScheduler.instance).asSingle()
    }
}
