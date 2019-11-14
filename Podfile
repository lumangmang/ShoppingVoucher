# Uncomment the next line to define a global platform for your project
#source 'http://repo.baichuan-ios.taobao.com/baichuanSDK/AliBCSpecs.git'
platform :ios, '11.0'

target 'ShoppingVoucher' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!
  
pod 'RxSwift'
pod 'RxCocoa'
pod 'AlibcTradeSDK'
pod 'AliAuthSDK'
pod 'mtopSDK','3.0.0.4'
pod 'securityGuard','5.4.173'
pod 'AliLinkPartnerSDK','4.0.0.24'
pod 'BCUserTrack','5.2.0.11-appkeys'
pod 'UTDID','1.1.0.16'
pod 'RAMAnimatedTabBarController'
pod 'CocoaLumberjack/Swift'
pod 'Moya/RxSwift', '14.0.0-beta.5'
pod 'SwifterSwift'
pod 'ObjectMapper'
pod 'NSObject+Rx'
pod 'Hero'
pod 'RAMAnimatedTabBarController'
pod 'NVActivityIndicatorView'

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'RxSwift'
      target.build_configurations.each do |config|
        if config.name == 'Debug'
          config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
        end
      end
    end
  end
end
