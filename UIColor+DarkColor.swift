//
//  UIColor+DarkColor.swift
//  MVVMDemo
//
//  Created by Chao Lv on 2022/6/10.
//

import Foundation
import UIKit

extension UIColor {
    //MARK: 暗黑模式和明亮模式的颜色区别
     class func gennerateDynamicLightColorAndDarkColor(lightColor:UIColor,darkColor : UIColor) -> UIColor  {
         let dyColor = UIColor.init { traitCollection in
             if traitCollection.userInterfaceStyle == .light {
                 return lightColor
             }else{
                 return darkColor
             }
             
         }
         return dyColor
    }
    //十六进制颜色转RGB
    class func colorWithHexString(colorHexString : String) -> UIColor {
        var red: UInt64 = 0, green:UInt64 = 0 , blue:UInt64 = 0
        var hex = colorHexString
        if hex.hasPrefix("0x") || hex.hasPrefix("0X") {
            hex = String(hex[hex.index(hex.startIndex,offsetBy: 2)])
        }else if hex.hasPrefix("#"){
            hex = String(hex[hex.index(hex.startIndex,offsetBy: 1)])
        }
        if hex.count < 6 {
            for _ in 0 ..< 6 - hex.count {
                hex += "0"
            }
        }
        // 分别进行转换
        // 红
        Scanner(string: String(hex[..<hex.index(hex.startIndex, offsetBy: 2)])).scanHexInt64(&red)
        // 绿
        Scanner(string: String(hex[hex.index(hex.startIndex, offsetBy: 2)..<hex.index(hex.startIndex, offsetBy: 4)])).scanHexInt64(&green)
        // 蓝
        Scanner(string: String(hex[hex.index(hex.startIndex, offsetBy: 4)...])).scanHexInt64(&blue)
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    }
}
