//
//  UIFont+fontName.swift
//  MVVMDemo
//
//  Created by Chao Lv on 2022/6/13.
//

import Foundation
import UIKit

//MARK: font 绑定字体
extension UIFont {
    
    class func neueMontrealMediumWithFontSize(size : CGFloat)->Self{
        return UIFont.init(name: "NeueMontreal-Medium", size: size) as! Self
    }
    class func neueMontrealRegularWithFontSize(size:CGFloat) -> Self{
        return UIFont.init(name: "NeueMontreal-Regular", size: size) as! Self
    }
    class func sourceHanSansCNRegularWithFontSize(size:CGFloat) -> Self{
        return UIFont.init(name: "SourceHanSansCN-Regular", size: size) as! Self
    }
    class func sourceHanSansCNBoldWithFontSize(size:CGFloat) -> Self{
        return UIFont.init(name: "SourceHanSansCN-Bold", size: size) as! Self
    }
    class func favoritStdBoldExtendedWithFontSize(size:CGFloat) -> Self{
        return UIFont.init(name: "FavoritStd-BoldExtended", size: size) as! Self
    }
}
