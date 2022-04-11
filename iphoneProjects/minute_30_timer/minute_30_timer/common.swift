//
//  common.swift
//  minute_30_timer
//
//  Created by 目黒丈一郎 on 2021/09/12.
//

import UIKit

let screenSize = UIScreen.main.bounds
let yoko = screenSize.width
let tate = screenSize.height
let commonW = CGFloat(yoko * 0.618)
let commonH = CGFloat(tate * 0.0826)

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

