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
        static let baseURL = "https://api.baicai.top/v4"
    }
    
    struct Dimensions {
        static let inset: CGFloat = 10
        static let tabBarHeight: CGFloat = 58
        static let toolBarHeight: CGFloat = 66
        static let navBarWithStatusBarHeight: CGFloat = 64
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 1
        static let buttonHeight: CGFloat = 40
        static let textFieldHeight: CGFloat = 40
        static let tableRowHeight: CGFloat = 40
        static let segmentedControlHeight: CGFloat = 36
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
