//
//  extensions.swift
//  yopparaicheck1
//
//  Created by 目黒丈一郎 on 2021/09/29.
//

import UIKit

let lineurl = URL(string:"https://line.me/R/")


extension UIView{
    func addInto(_ parentView: UIView, xRate: CGFloat, yRate: CGFloat){
        let width = self.bounds.width
        let height = self.bounds.height
        parentView.addSubview(self)
        self.frame.origin.x = parentView.bounds.width * xRate - width / 2
        self.frame.origin.y = parentView.bounds.height * yRate - height / 2
    }
    
    func setSize(_ width: CGFloat, _ height: CGFloat){
        self.bounds.size.width = width
        self.bounds.size.height = height
    }
    
    func set(_ parentView: UIView, widthRate: CGFloat, heightRate: CGFloat, xRate: CGFloat, yRate: CGFloat){
        setSize(parentView.wRate(widthRate), parentView.hRate(heightRate))
        addInto(parentView, xRate: xRate, yRate: yRate)
    }
    
    func wRate(_ rate: CGFloat) -> CGFloat{
        return self.bounds.width * rate
    }
    
    func hRate(_ rate: CGFloat) -> CGFloat{
        return self.bounds.height * rate
    }
    func removeAllSubviews(){
        var subviews = self.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}

class aaButton: UIButton {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.animationTouchBegan()
    }
    
    private func animationTouchBegan(){
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)}, completion: nil)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.animationTouchEnded()
    }
    
    private func animationTouchEnded(){
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)}, completion: nil)
    }

}
