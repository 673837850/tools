//
//  UIButton+Factory.swift
//  MVVMDemo
//
//  Created by Chao Lv on 2022/6/13.
//

import Foundation
import UIKit

extension UIButton {
    class func buttonWithTitle(_ title:String, and backGroundColor:UIColor) -> Self{
        let btn = self.init(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.tintColor = UIColor.white
        btn.backgroundColor = backGroundColor
        return btn
        
    }
    class func customButtonWith(title : String ,and backGroundColor : UIColor) -> Self{
        let btn = self.buttonWithTitle(title, and: UIColor.white)
        btn.tintColor = UIColor.white
        btn.backgroundColor = backGroundColor
        return btn
        
    }
    
    class func buttonWithNormaleImage(_ image : UIImage) -> Self{
        return self.buttonWithNormalImage(image, andSelectImage: nil, highlightedImage: nil, title: nil)
        
    }
    class func buttonWithNormal(_ image:UIImage, and selectImage: UIImage) -> Self{
        return self.buttonWithNormalImage(image, andSelectImage: selectImage, highlightedImage: nil, title: nil)
    }
    class func buttonWithNormalImage(_ image : UIImage, andTitle title:String) -> Self{
        return self.buttonWithNormalImage(image, andSelectImage: nil, highlightedImage: nil, title: title)
    }
    class func buttonWithNormalImage(_ image:UIImage,andSelectImage selectImage:UIImage?, highlightedImage:UIImage?, title:String?) -> Self{
        let btn = self.init(type: .custom)
        btn.setImage(image, for: .normal)
        btn.setImage(selectImage, for: .selected)
        btn.setImage(highlightedImage, for: .highlighted)
        btn.setTitle(title, for: .normal)
        return btn
    }
}


struct DB<Base> {
    var base:Base
    init (_ base :Base){
        self.base = base
    }
}
//MARK: -UIColor 拓展
extension UIColor {
    var db:DB<UIColor>{
        DB(self)
    }
}

//MARK: -UIButton的分类拓展
extension UIButton{
    var db:DB<UIButton>{
        DB(self)
    }
}

extension DB where Base:UIButton{
    func buttonWithImage(_ image:UIImage?,selectImage:UIImage?,normalTitle:String?){
        self.base.setImage(image, for: .normal)
        self.base.setTitleColor(UIColor.blue, for: .normal)
        self.base.setImage(selectImage, for: .selected)
        self.base.setTitle(normalTitle, for: .normal)
    }
}

//MARK: UIIMageView的分类拓展
extension UIImageView{
    var db:DB<UIImageView>{
        DB(self)
    }
}
//FIXME: UIImageView的拓展处理待完善
extension DB where Base:UIImageView{
    func setImageWith(imageName:String){
        self.base.image = UIImage.init(named: imageName)
    }
}

//MARK: Label对象的方法拓展
extension UILabel {
    var db:DB<UILabel>{
        return DB(self)
    }
}
extension DB where Base:UILabel{
    func setText(_ text:String,color:UIColor,font:UIFont){
        self.base.text = text
        self.base.font = font
        self.base.textColor = color
    }
}

extension String{
    var db:DB<String>{
        DB(self)
    }
}
extension DB where Base == String{
    func numCount() -> Int{
        var count = 0
        for c in self.base where ("0"..."9").contains(c){
            count = count + 1
        }
        return count
        
    }
}
