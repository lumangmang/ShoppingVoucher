//
//  HelpersManager.swift
//  ShoppingVoucher
//
//  Created by Mac on 2019/11/13.
//  Copyright © 2019 Mac. All rights reserved.
//

import DropDown
import Toast_Swift
import KafkaRefresh
import CocoaLumberjack
import Kingfisher
import RxCocoa
import RxSwift

final class HelpersManager: NSObject {
    
    static let `default` = HelpersManager()
    
    public func setupThirdLibs() {
        
        setupCocoaLumberjack()
        setupAlibcTradeSDK()
        
        setupTheme()
        setupDropDown()
        setupToast()
        setupKafkaRefresh()
    }
    
    
    private func setupKingfisher() {
        // Set maximum disk cache size for default cache. Default value is 0, which means no limit.
        ImageCache.default.diskStorage.config.sizeLimit = UInt(500 * 1024 * 1024) // 500 MB

        // Set longest time duration of the cache being stored in disk. Default value is 1 week
        ImageCache.default.diskStorage.config.expiration = .days(7) // 1 week

        // Set timeout duration for default image downloader. Default value is 15 sec.
        ImageDownloader.default.downloadTimeout = 15.0 // 15 sec
    }
    
   private func setupKafkaRefresh() {
        if let defaults = KafkaRefreshDefaults.standard() {
            defaults.headDefaultStyle = .replicatorAllen
            defaults.footDefaultStyle = .replicatorDot
            ThemManager.rx
                .bind({ $0.secondary }, to: defaults.rx.themeColor)
                .disposed(by: rx.disposeBag)
        }
    }
    
    private func setupDropDown() {
        
        ThemManager.attrsStream.subscribe(onNext: { theme in
            DropDown.appearance().backgroundColor = theme.primary
            DropDown.appearance().selectionBackgroundColor = theme.primaryDark
            DropDown.appearance().textColor = theme.text
            DropDown.appearance().selectedTextColor = theme.text
            DropDown.appearance().separatorColor = theme.separator
        }).disposed(by: rx.disposeBag)
    }
    
    private func setupToast() {
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.position = .top
        var style = ToastStyle()
        style.backgroundColor = UIColor.Material.red
        style.messageColor = UIColor.Material.white
        style.imageSize = CGSize(width: 30, height: 30)
        ToastManager.shared.style = style
    }
    
    private func setupTheme() {
        ThemManager.rx.bind({
            $0.statusBarStyle
        }, to: UIApplication.shared.rx.statusBarStyle).disposed(by: rx.disposeBag)
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

extension HelpersManager {
    
    func removeKingfisherCache() -> Observable<Void> {
           return ImageCache.default.rx.clearCache()
       }
    
    func kingfisherCacheSize() -> Observable<Int> {
        return ImageCache.default.rx.retrieveCacheSize()
    }
}
