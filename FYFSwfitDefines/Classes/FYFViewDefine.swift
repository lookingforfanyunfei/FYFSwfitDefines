//
//  FYFViewDefine.swift
//  FBSnapshotTestCase
//
//  Created by 范云飞 on 2022/3/11.
//


import UIKit

public struct FYFViewDefine {
    /// 屏幕高度
    public static let FYFScreenHeight = UIScreen.main.bounds.size.height
    /// 屏幕宽度
    public static let FYFScreenWidth = UIScreen.main.bounds.size.width
    /// 设备宽度
    public static let FYFDeviceWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    /// 设备高度
    public static let FYFDeviceHeight = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    
    /// 判断刘海
    public static let FYFIsIphoneX = isNotchDevice()
    
    /// 状态栏
    public static let FYFSysStatusBarHeight = isNotchDevice() ? 44.0 : 20.0
    public static let FYFStatusBarCurrHeight = UIApplication.shared.statusBarFrame.size.height
    /// 热点栏高度
    public static let FYFSysHotSpotStatusBarHeight = isNotchDevice() ? 0.0 : 20.0
    /// 根据APP_STATUSBAR_HEIGHT判断是否存在热点栏 iphoneX中永远是NO
    public static let FYFIsHotSpotOrCallingState = isNotchDevice() ? false : ((FYFStatusBarCurrHeight >= (FYFSysStatusBarHeight + FYFSysHotSpotStatusBarHeight)) ? true : false)
    public static let FYFHotSpotStatusBarHeight = FYFIsHotSpotOrCallingState ? 20.0 : 0.0
    
    /// 实际状态栏高度
    public static let FYFStatusBarHeight = FYFIsHotSpotOrCallingState ? (FYFStatusBarCurrHeight-FYFSysHotSpotStatusBarHeight) : FYFStatusBarCurrHeight
    
    
    /// navigationBar
    public static let FYFNavigationBarHeight = getNavigationBarHeight()
    public static let FYFNavigationBarFullHeight = getNavigationBarHeight() + FYFStatusBarHeight
    public static let FYFNavigatonBarTopSpace = UIApplication.shared.statusBarFrame.size.height
    
    /// tabBar
    public static let FYFTabBarHeight = getTabBarHeight()
    public static let FYFTabBarFullHeight = getSafeAreaBottom() + getTabBarHeight()
    public static let FYFTabBarBottomSpace = getSafeAreaBottom()
    
    
    /// 屏幕适配
    /// - Parameter value: <#value description#>
    /// - Returns: <#description#>
    public static func viewScale(_ value: CGFloat) -> CGFloat {
        return ceil((FYFDeviceWidth / 375.0) * value)
    }
    
    /// 判断刘海屏
    /// - Returns: <#description#>
    public static func isNotchDevice() -> Bool {
        var __efIsIphonex = false
        if #available(iOS 11.0, *) {
            if let mainWindow: UIWindow = UIApplication.shared.delegate?.window! {
                __efIsIphonex = mainWindow.safeAreaInsets.bottom > 0.0
            }
        }
        return __efIsIphonex
    }
    
    /// 获取屏幕底部安全距离
    public static func getSafeAreaBottom() -> CGFloat {
        var __efSafeAreaBottom = 0.0
        if #available(iOS 11.0, *) {
            if let mainWindow: UIWindow = UIApplication.shared.delegate?.window! {
                __efSafeAreaBottom = mainWindow.safeAreaInsets.bottom
            }
        }
        return __efSafeAreaBottom
    }
    
    /// 导航栏高度
    /// - Returns: <#description#>
    public static func getNavigationBarHeight() -> CGFloat {
        var __efNavigationBarHeight = 44.0
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            if isNotchDevice() {
                /// 全面屏 pad 是 50
                __efNavigationBarHeight = 55.0
            } else {
                if #available(iOS 12.0, *) {
                    /// 普通pad iOS12后也是50
                    __efNavigationBarHeight = 50.0
                }
            }
        }
        return __efNavigationBarHeight
    }
    
    /// tabBar高度
    /// - Returns: <#description#>
    public static func getTabBarHeight() -> CGFloat {
        var __efTabBarHeight = 49.0
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            if isNotchDevice() {
                /// 全面屏 pad 是 45, 外加底部20的安全区域就是65
                __efTabBarHeight = 55.0
            } else {
                if #available(iOS 12.0, *) {
                    /// 普通pad iOS12后也是50
                    __efTabBarHeight = 50.0
                }
            }
        }
        return __efTabBarHeight
    }
}
