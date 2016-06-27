//
//  AppDelegate.swift
//  08-WXShared
//
//  Created by zhaoyou on 16/6/24.
//  Copyright © 2016年 zhaoyou. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 微信分享注册id
        WXApi.registerApp("wxd930ea5d5a258f4f")
        
        
        return true
    }

    // MARK: - 微信分享
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return WXApi.handleOpenURL(url, delegate: self)
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        return WXApi.handleOpenURL(url, delegate: self)
    }
    
    func onReq(req: BaseReq!) {
        print(#function)
    }
    
    func onResp(resp: BaseResp!) {
        print(#function)
        guard !resp.isKindOfClass(SendMessageToWXReq) else {
            return
        }
        
        if resp.errCode == WXSuccess.rawValue {
            print("分享成功")
        } else {
            print("分享失败")
            print(resp.errCode)
        }
    }

}

