//
//  VoucherAPI.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import Moya
import SwifterSwift
import RxSwift
import RxCocoa

enum VoucherAPI {
    case loading
    case index //  /taoke/category
}

extension VoucherAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .loading: return Helpers.Networking.lodingURL.url!
        default: return Helpers.Networking.baseURL.url!
        }
    }
    
    var path: String {
        switch self {
        case .loading: return "/liuyi/cloud/toggle/shanwuleng/tiandihe/caiganyujunjue"
        case .index: return "/taoke/category"
        }
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .loading:
            params["appKey"] = Keys.loading.apiKey
            params["deviceId"] = Keys.loading.deviceID
        case .index:
            params["search"] = "parent_id:0;status:1"
            params["orderBy"] = "sort"
            params["sortedBy"] = "desc"
            params["searchJoin"] = "and"
            params["type"] = "1"
        }
        return params
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}
