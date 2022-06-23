//
//  String+show.swift
//  MVVMDemo
//
//  Created by Chao Lv on 2022/6/8.
//

import Foundation
import UIKit


extension String {
    
    //MARK: 获得当前文字的首字母
    func firstCharactor() -> String {
        let mutableString = NSMutableString.init(string: self)
        //将中文转换成声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        //去掉声调
        let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        //将字符串换成大写
        let strPinYin = pinyinString.uppercased()
        //截取首字母
        let firstString = String(strPinYin.prefix(1))
        
        //判断首字母是否大写
        let regexA = "^[A-Z]$"
        let preA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        let ss = preA.evaluate(with: firstString) ? firstString : "#"
        
        return ss
    }
    
    //MARK:获取文字的高度
    func sizeWithFont(font : UIFont , maxW : CGFloat) -> CGSize {
        let attris = [NSAttributedString.Key.font : font]
        let size = CGSize(width: maxW, height: CGFloat(MAXFLOAT))
        return NSString.init(string: self).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attris, context: nil).size
    }
}
