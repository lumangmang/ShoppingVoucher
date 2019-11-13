//
//  LogManager.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/13.
//  Copyright © 2019 Mac. All rights reserved.
//

import RxSwift
import CocoaLumberjack

public func LogDebug(_ message: @autoclosure () -> String) {
    DDLogDebug(message())
}

public func LogError(_ message: @autoclosure () -> String) {
    DDLogError(message())
}

public func LogInfo(_ message: @autoclosure () -> String) {
    DDLogInfo(message())
}

public func LogVerbose(_ message: @autoclosure () -> String) {
    DDLogVerbose(message())
}

public func LogWarn(_ message: @autoclosure () -> String) {
    DDLogWarn(message())
}

public func LogResourcesCount() {
    #if DEBUG
    LogDebug("RxSwift resources count: \(RxSwift.Resources.total)")
    #endif
}
