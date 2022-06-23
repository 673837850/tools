//
//  MBProgressHUD+Tip.swift
//  MVVMDemo
//
//  Created by Chao Lv on 2022/6/10.
//

import Foundation
import MBProgressHUD


extension MBProgressHUD {
    
    //MARK: hud提示success
    class func showSuccess(tip: String) -> Self{
        return self.showMessage(tip, to: nil)
    }
    
    //MARK: hud提示绑定view
    class func showSuceess(success :String, to view : UIView) -> Self{
        return self.showMessage(success, and: "success.png", addTo: view)
    }
    
    class func showMessage(_ message:String,and icon:String, addTo view : UIView?) -> Self{
        var backView : UIView?
        if view == nil {
            backView = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
        }else{
            backView = view
        }
        let hud = MBProgressHUD.init(view: backView!)
        backView?.addSubview(hud)
        hud.label.text = message
        hud.label.numberOfLines = 0
        hud.customView = UIImageView.init(image: UIImage.init(named: icon))
        hud.mode = .customView
        hud.bezelView.style = .solidColor
        hud.removeFromSuperViewOnHide = true
        hud.label.textColor = UIColor.white
        hud.hide(animated: true, afterDelay: 1.2)
        return hud as! Self
    }
    
    class func showMessage(_ message : String, to view:UIView?) -> Self{
        var backView : UIView?
        if view == nil {
            backView = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
        }else{
            backView = view
        }
        let hud = Self.showAdded(to: backView!, animated: true)
        hud.label.text = message
        hud.label.numberOfLines = 0
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor.black.withAlphaComponent(0.65)
        hud.contentColor = UIColor.white
        hud.isUserInteractionEnabled = false
        return hud 
    }
    
    class func showMessageOnScreenBottom(_ message:String, hideAfterTime:TimeInterval){
        let hud = MBProgressHUD.showMessage(message, to: nil)
        hud.mode = .text
        hud.label.font = UIFont.systemFont(ofSize: 16)
        hud.label.numberOfLines = 0
        hud.bezelView.layer.cornerRadius = 2
        var offset = hud.offset
        offset.y = UIScreen.main.bounds.size.height*0.25
        hud.offset = offset
        hud.bezelView.transform = CGAffineTransform.init(scaleX: 10.0/9.0, y: 10.0/7.0)
        hud.hide(animated: true, afterDelay: hideAfterTime)
    }
}
