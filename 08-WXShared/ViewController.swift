//
//  ViewController.swift
//  08-WXShared
//
//  Created by zhaoyou on 16/6/24.
//  Copyright © 2016年 zhaoyou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    // MARK: Private Method
    private func setupUI() {
        // 判断用户是否安装微信,并且判断当前微信版本是否支持分享
        if WXApi.isWXAppInstalled() && WXApi.isWXAppSupportApi() {
            shareButton.addTarget(self, action: #selector(self.shareButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
            
            view.addSubview(shareButton)
            
            shareButton.frame = CGRect(x: 10, y: 100, width: 100, height: 40)
        }
    }
    /**
     分享文本
     
     - returns: Bool
     */
    private func sendText(text: String, inScene: WXScene) -> Bool {
        let req = SendMessageToWXReq()
        req.text = text
        req.bText = true
        // 分享到微信的场景
        req.scene = Int32(inScene.rawValue)
        
        return WXApi.sendReq(req)
    }
    /**
     发送图片
     
     - returns: Bool
     */
    private func sendImage(image: UIImage, inScene: WXScene) -> Bool {
        let ext = WXImageObject()
        ext.imageData = UIImagePNGRepresentation(image)
        let message=WXMediaMessage()
        message.title=nil
        message.description=nil
        message.mediaObject=ext
        message.mediaTagName="MyPic"
        //生成缩略图
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
        image.drawInRect(CGRectMake(0, 0, 100, 100))
        let thumbImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        message.thumbData=UIImagePNGRepresentation(thumbImage)
        
        let req=SendMessageToWXReq()
        req.text=nil
        req.message=message
        req.bText=false
        // 分享到微信的场景
        req.scene = Int32(inScene.rawValue)
        
        return WXApi.sendReq(req)
    }
    /**
     发送链接
     
     - parameter URLStr:  链接
     - parameter inScene: 分享到微信的场景（会话、朋友圈、收藏）
     */
    private func sendLinkContent(URLStr: String, inScene: WXScene) {
        let message = WXMediaMessage()
        message.title = "小左测试：标题"
        message.description = "小左测试：具体的文本内容--微信的平台化发展方向是否真的会让这个原本简洁的产品变得臃肿？在国际化发展方向上，微信面临的问题真的是文化差异壁垒吗？腾讯高级副总裁、微信产品负责人张小龙给出了自己的回复。"
        message.setThumbImage(UIImage(named: "Snip20160624_5"))
        
        let ext = WXWebpageObject()
        ext.webpageUrl = URLStr
        
        message.mediaObject = ext
        
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        // 分享到微信的场景
        req.scene = Int32(inScene.rawValue)
        
        WXApi.sendReq(req)
    }
    
    // MARK: Action
    /**
     分享按钮点击
     */
    @objc private func shareButtonClick() {
//        sendText("测试微信文本分享", inScene: WXSceneTimeline)
//        sendImage(UIImage(named: "Snip20160624_5")!, inScene: WXSceneSession)
        sendLinkContent("http://www.baidu.com", inScene: WXSceneTimeline)
    }

    // MARK: Lazy
    private lazy var shareButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("分享至微信", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
        btn.setBackgroundImage(UIImage.imageWithColor(UIColor.greenColor()), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage.imageWithColor(UIColor.brownColor()), forState: UIControlState.Highlighted)
        
        return btn
    }()
}

