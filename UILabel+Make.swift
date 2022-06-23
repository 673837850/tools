//
//  UILabel+Make.swift
//  MVVMDemo
//
//  Created by Chao Lv on 2022/6/13.
//

import Foundation
import UIKit

extension UILabel {
    //MARK: label 展示文字 字体 颜色 
    class func labelWithText(_ text:String, andSystemfont font:UIFont, andTextColor color:UIColor) -> Self{
        let label = self.init()
        label.text = text
        label.textAlignment = .left
        label.font = font
        label.textColor = color
        return label
    }
    class func labelWithText(_ text:String ,andBoldSystemFont font:UIFont,andTextColor color:UIColor) -> Self{
        let label = self.init()
        label.text = text
        label.textAlignment = .left
        label.font = font
        label.textColor = color
        return label
    }
    class func labelWithText(_ text:String, andCustomFont font:UIFont, andTextColor color : UIColor) -> Self{
        let label = self.init()
        label.text = text
        label.textAlignment = .left
        label.font = font
        label.textColor = color
        return label
    }
    
}
