//
//  extensions.swift
//  minute_30_timer
//
//  Created by 目黒丈一郎 on 2021/09/12.
//

import UIKit

extension UIView{
    
    func w(_ width: CGFloat){
        self.bounds.size.width = width
    }
    
    var w: CGFloat{return self.bounds.width}
    
    
    func h(_ height: CGFloat){
        self.bounds.size.height = height
    }
    
    var h: CGFloat{return self.bounds.height}
    
    func setSub(_ sub: UIView, _ x_rate: CGFloat = 0.5, _ y_rate: CGFloat = 0.5){
        let par_width = self.w
        let par_height = self.h
        self.addSubview(sub)
        sub.center = CGPoint(x: par_width * x_rate, y: par_height * y_rate)
    }
    
    
    func setSize(_ width: CGFloat, _ height: CGFloat){
        self.w(width)
        self.h(height)
    }
    
    func setSub(_ sub: UIView, _ width: CGFloat, _ height: CGFloat, _ xrate: CGFloat, _ yrate: CGFloat){
        sub.w(width)
        sub.h(height)
        self.setSub(sub, xrate, yrate)
    }
    
    func addInto(_ per: UIView, _ width: CGFloat, _ height: CGFloat, _ xrate: CGFloat, _ yrate: CGFloat){
        self.w(width)
        self.h(height)
        per.setSub(self, xrate, yrate)
    }
    
    func addInto(_ per: UIView, xrate: CGFloat, yrate: CGFloat){
        per.addSubview(self)
        self.center = CGPoint(x: per.w * xrate, y: per.h * yrate)
    }
    
    func fitSub(_ sub: UIView, rate: CGFloat = 1){
        sub.w(self.w * rate)
        sub.h(self.h * rate)
        self.setSub(sub)
    }
}

extension UILabel{
    func typeA(_ text: String){
        self.w(commonW)
        self.h(commonH)
        self.backgroundColor = .systemGray
        self.text = text
        self.textAlignment = .center
        self.textColor = .white
    }
}

extension UIButton{
    func typeA(_ text: String){
        self.w((yoko - commonW) * 0.3)
        self.h(commonH * 0.4)
        self.backgroundColor = .systemGray
        self.setTitle(text, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.yellow, for: .highlighted)
    }
}
