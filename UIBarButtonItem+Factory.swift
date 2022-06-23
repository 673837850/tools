//
//  UIBarButtonItem+Factory.swift
//  MVVMDemo
//
//  Created by Chao Lv on 2022/6/13.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    //UIBarbuton 绑定事件 图片
    class func itemWithTarget(target:Any, action:Selector, image : String ,highImage :String) -> UIBarButtonItem{
        let btn = UIButton.init(type: .custom)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setBackgroundImage(UIImage.init(named: image), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: highImage), for: .highlighted)
        btn.frame.size = btn.currentBackgroundImage?.size ?? CGSize.init(width: 10, height: 10)
        return UIBarButtonItem.init(customView: btn)
    }
    class func itemWithTarget(_ target : Any ,action : Selector,image : String, hightImage:String, offset : CGFloat) -> Array<Any>{
        let btn = UIButton.init(type: .custom)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setBackgroundImage(UIImage.init(named: image), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: hightImage), for: .selected)
        btn.frame.size = btn.currentBackgroundImage?.size ?? CGSize.init(width: 10, height: 10)
        let barButton = UIBarButtonItem.init(customView: btn)
        let nagativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: target, action: action)
        nagativeSpacer.width = offset
        return  Array.init(arrayLiteral: nagativeSpacer,barButton)
    }
    
}
