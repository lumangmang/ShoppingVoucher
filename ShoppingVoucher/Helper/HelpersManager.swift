//
//  HelpersManager.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/13.
//  Copyright © 2019 Mac. All rights reserved.
//

import CocoaLumberjack


final class HelpersManager {
    
    static let `default` = HelpersManager()
    
    public func setupThirdLibs() {
        
        setupCocoaLumberjack()
        setupAlibcTradeSDK()
    }
    
    private func setupCocoaLumberjack() {
        DDLog.add(DDTTYLogger.sharedInstance)
        let fileLogger: DDFileLogger = DDFileLogger()
        fileLogger.rollingFrequency = TimeInterval(60*60*24)
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
    
    private func setupAlibcTradeSDK() {
        AlibcTradeSDK.sharedInstance()?.asyncInit(success: {
            LogInfo("Init AlibcTradeSDK Success")
        }, failure: { error in
            LogError(error.debugDescription)
        })
        AlibcTradeSDK.sharedInstance()?.setDebugLogOpen(false)
    }
}
