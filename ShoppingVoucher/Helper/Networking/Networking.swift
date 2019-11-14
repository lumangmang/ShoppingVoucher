//
//  Networking.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import RxCocoa
import RxSwift
import ObjectMapper
import Moya

class OnlineProvider<Target> where Target: Moya.TargetType {
    fileprivate let online: Observable<Bool>
    fileprivate let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping, requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping, stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub, session: Session = MoyaProvider<Target>.defaultAlamofireSession(), plugins: [PluginType] = [], trackInflights: Bool = false, online: Observable<Bool> = connectedToInternet()) {
        
        self.online = online
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, session: session, plugins: plugins, trackInflights: trackInflights)
    }
    
    func request(_ token: Target) -> Observable<Moya.Response> {
        let actualRequest = provider.rx.request(token)
        return online.ignore(value: false).take(1).flatMap { _ in
            return actualRequest.filterSuccessfulStatusCodes().do(onSuccess: { response in
                
            }, onError: { error in
                if let error = error as? MoyaError {
                    switch error {
                    case .statusCode(let response):
                        if response.statusCode == 401 {
                            
                        }
                    default:
                        break
                    }
                }
            })
        }
    }
}

protocol NetworkingType {
    associatedtype T: TargetType
    var provider: OnlineProvider<T> { get }
}

struct Networking: NetworkingType {
    typealias T = VoucherAPI
    let provider: OnlineProvider<VoucherAPI>
}

extension Networking {
    func request(_ token: VoucherAPI) -> Observable<Moya.Response> {
        let actualRequest = self.provider.request(token)
        return actualRequest
    }
}


