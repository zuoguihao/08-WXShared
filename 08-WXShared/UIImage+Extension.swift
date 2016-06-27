//
//  UIImage+Extension.swift
//  08-WXShared
//
//  Created by zhaoyou on 16/6/24.
//  Copyright © 2016年 zhaoyou. All rights reserved.
//

import UIKit

extension UIImage {
    /**
     扩展UIImage：用颜色生成一张图片
     */
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

