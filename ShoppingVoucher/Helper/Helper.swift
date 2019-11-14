//
//  Helper.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/14.
//  Copyright © 2019 Mac. All rights reserved.
//

import RxSwift
import Alamofire

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


struct Helpers {
    
    struct Networking {
        static let lodingURL = "http://api.652615.com"
    }
}

enum Keys {
    case loading
    
    var apiKey: String {
        switch self {
        case .loading: return "3dee1e3ebf5d41f12821f04c0b3aad00"
        }
    }
    
    var deviceID: String {
        return "UTDevice"
    }
}


private class ReachabilityManager: NSObject {
    
    static let `default` = ReachabilityManager()
    
    let reachSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        return reachSubject.asObservable()
    }
    
    override init() {
        super.init()
        
        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable: self.reachSubject.onNext(false)
            case .reachable: self.reachSubject.onNext(true)
            case .unknown: self.reachSubject.onNext(false)
            }
        })
    }
}

func connectedToInternet() -> Observable<Bool> {
    return ReachabilityManager.default.reach
}
