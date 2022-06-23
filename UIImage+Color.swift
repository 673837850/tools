//
//  UIImage+Color.swift
//  MVVMDemo
//
//  Created by Chao Lv on 2022/6/23.
//

import Foundation
import UIKit


extension UIImage {
    
    //MARK: 颜色转image
    class func imageWithColor(_ color : UIColor) -> UIImage{
        return UIImage.imageWithColor(color, and: CGSize(width: 1, height: 1))
    }
    
    class func imageWithColor(_ color :UIColor ,and size:CGSize) -> Self{
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return image! as! Self
    }
    //按指定大小生成缩略图
    class func thumbnailWithImage(_ image:UIImage? , aSize : CGSize) -> UIImage{
        var newImage : UIImage?
        if image == nil {
            newImage = nil
        }else{
            UIGraphicsBeginImageContext(aSize)
            image?.draw(in: CGRect.init(x: 0, y: 0, width: aSize.width, height: aSize.height))
            newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return newImage!
    }
    //保持原来长宽高声成一个缩略图
    class func thumbakWithImageWithoutScale(_ image : UIImage?,and aSize:CGSize ) -> UIImage{
        var newImage : UIImage?
        if image == nil {
            newImage = nil
        }else{
            let oldSize = image!.size
            var rect : CGRect?
            if aSize.width/aSize.height > oldSize.width/oldSize.height {
                rect = CGRect(x: 0, y: (aSize.width - (rect?.size.width ?? 0))*0.5, width: aSize.height * oldSize.width/oldSize.height, height: aSize.height)
            }
            UIGraphicsBeginImageContext(aSize)
            let context = UIGraphicsGetCurrentContext()
            context?.setFillColor(UIColor.clear.cgColor)
            UIRectFill(CGRect(x: 0, y: 0, width: aSize.width, height: aSize.height))
            image?.draw(in: rect!)
            newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return newImage!
    }
    
    func scaleToSize(size : CGSize) -> UIImage{
        if UIScreen.main.scale == 2.0 {
            UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
        }else{
            UIGraphicsBeginImageContext(size)
        }
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaleImage ?? UIImage.init()
    }
    
    class func zipNSDataWithImage(sourImage : UIImage) -> Data{
        let imageSize = sourImage.size
        var width = imageSize.width
        var height = imageSize.height
        if width>1280 || height > 1280 {
            if width>height {
                let scale = height/width
                width = 1280
                height = width * scale
            }else{
                let scale = width/height
                height = 1280
                width = height * scale
            }
        }else if(width > 1280 || height < 1280){
            let scale = height/width
            width = 1280
            height = width * scale
        }else if(width < 1280 || height > 1280){
            let scale = width/height
            height = 1280
            width = height * scale
        }else{}
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        sourImage.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        var data = newImage?.jpegData(compressionQuality: 1)
        if data?.count ?? 0 > 100 * 1024 {
            if data?.count ?? 0 > 1024 * 1024 {
                data = newImage?.jpegData(compressionQuality: 0.7)
            }else if data?.count ?? 0 > 512*1024{
                data = newImage?.jpegData(compressionQuality: 0.8)
            }else if data?.count ?? 0 > 200 * 1024{
                data = newImage?.jpegData(compressionQuality: 0.9)
            }
        }
        return data!
    }
}
