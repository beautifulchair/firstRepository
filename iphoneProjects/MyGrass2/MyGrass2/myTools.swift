//
//  myTools.swift
//  MyGrass2
//
//  Created by 目黒丈一郎 on 2021/02/27.
//

import UIKit
import MapKit
import CoreLocation
let screenSize = UIScreen.main.bounds
let yoko = screenSize.width
let tate = screenSize.height
var countQButton = 0
var myHomeLocation =  CLLocationCoordinate2D(latitude: 35, longitude: 0)
let rr = yoko / 12
var mpp = UIModalPresentationStyle.overCurrentContext
var nowPhoto: UIImage?
var nowTitle: String? = "title:"
var nowLoc: CLLocationCoordinate2D? = myHomeLocation
var nowPost = postData()
var photoSize = CGRect(x: 0, y: 0, width: yoko * 4 / 5, height: tate / 4 * 3)

let postviewcontroller = PostViewController()
let backviewcontroller = BackViewController()
let homeviewcontroller = HomeViewController()
let cameraviewcontroller = CameraViewController()
let titleviewcontroller = TitleViewController()
//let b = backviewcontroller
//let bbb = titleviewcontroller


enum controllerName: CaseIterable{
    case Friends, Post, Home, Mypage, Setting
    var imfo: (String, Int, String){
        switch self{
        case .Friends: return ("Friends", 0, "others")
        case .Post: return ("Post", 1, "camera")
        case .Home: return ("Home", 2, "home")
        case .Mypage: return ("My Page", 3, "mypage")
        case .Setting: return ("Setting", 4, "setting")
        }
    }
}

func fitSub(sub: UIView, par : UIView){
    let subWidth = sub.bounds.size.width
    let subHeight = sub.bounds.size.height
    let parWidth = par.bounds.size.width
    let parHeight = par.bounds.size.height
    par.addSubview(sub)
    sub.frame.origin.x = parWidth / 2 - subWidth / 2
    sub.frame.origin.y = parHeight / 2 - subHeight / 2
}

func setSubImage(parentView par:UIView, rate: CGFloat, imageName: String, ifround: Bool = false){
    let zSubView = UIImageView(image: UIImage(named: imageName))
    setSub(sub: zSubView, parentView: par, rate: rate, ifround: ifround)
}

func setSub(sub: UIView, parentView par: UIView, rate: CGFloat, ifround: Bool = false){
    sub.bounds.size.width = par.bounds.size.height * rate //note
    sub.bounds.size.height = par.bounds.size.height * rate
    fitSub(sub: sub, par: par)
    if ifround == true{
        sub.layer.cornerRadius = sub.bounds.size.width / 2
    }
}

func fittate(sub: UIView, parentView par: UIView){
    let subHeight = sub.bounds.size.height
    let parHeight = par.bounds.size.height
    par.addSubview(sub)
    sub.frame.origin.y = parHeight / 2 - subHeight / 2
}

func fityoko(sub: UIView, parentView par: UIView){
    let subWidth = sub.bounds.size.width
    let parWidth = par.bounds.size.width
    par.addSubview(sub)
    sub.frame.origin.x = parWidth / 2 - subWidth / 2
}

func maruiButton(rad: CGFloat = yoko / 12, centerX x: CGFloat, centerY y: CGFloat) -> UIButton{
    let zButton = aaButton()
    zButton.bounds.size.width = rad * 2
    zButton.bounds.size.height = rad * 2
    zButton.layer.cornerRadius = rad
    zButton.layer.borderWidth = 4
    zButton.frame.origin.x = x - rad
    zButton.frame.origin.y = y - rad
    return zButton
}

func returnImageview(imageName: String) -> UIImageView{
    return UIImageView(image: UIImage(named: imageName))
}

func resetView(view: UIView){
    let views = view.subviews
    for v in views{
        v.removeFromSuperview()
    }
}

extension UIViewController{
    
    @objc func toHome(){
        print(#function, "start")
        print(self)
        homeviewcontroller.modalPresentationStyle = .fullScreen
        self.dismiss(animated: false, completion: {titleviewcontroller.present(homeviewcontroller, animated: false, completion: nil)})
        print(#function, "finish")
    }
    
    @objc func toCamera(){
        print(#function)
        cameraviewcontroller.modalPresentationStyle = .popover
        self.present(cameraviewcontroller, animated: true, completion: nil)
    }
    
    @objc func toTitle(){
        print(#function)
        titleviewcontroller.modalPresentationStyle = .fullScreen
        self.dismiss(animated: false, completion: {backviewcontroller.present(titleviewcontroller, animated: false, completion: nil)})
    }
    
    @objc func toPost(){
        print(#function)
        postviewcontroller.modalPresentationStyle = .fullScreen
        self.dismiss(animated: false, completion: {titleviewcontroller.present(postviewcontroller, animated: false, completion: nil)})
    }
    
    @objc func resetAndReload(){
        self.resetViewController()
        self.viewDidLoad()
    }
    
    func resetViewController() {
        resetView(view: self.view)
    }
    
}

func createSomeButton(k: Int, col: UIColor, title: String, imageName: String) -> UIButton{
    let zButton = ccButton()
    let ss = CGFloat(5)
    let k = CGFloat(k-1)
    let ww = CGFloat(4)
    zButton.backgroundColor = col
    zButton.setTitleColor(.yellow, for: .highlighted)
    zButton.layer.borderColor = UIColor.gray.cgColor
    zButton.layer.borderWidth = ww
    zButton.bounds.size.width = yoko / ss + ww / 2
    zButton.bounds.size.height = tate / 9 + ww / 2
    zButton.frame.origin.x = yoko / ss * k
    zButton.frame.origin.y = tate - tate / 9
    setSubImage(parentView: zButton, rate: 0.5, imageName: imageName)
    let zLabel = UILabel()
    zButton.addSubview(zLabel)
    zLabel.bounds.size.height = zButton.bounds.size.height * 0.25
    zLabel.bounds.size.width = zButton.bounds.size.width
    zLabel.text = title
    zLabel.textColor = .white
    zLabel.frame.origin.x = 0
    zLabel.frame.origin.y = 0
    zLabel.textAlignment = NSTextAlignment.center
    return zButton
}

func colar(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    let col = UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    return col
}

func setBottomBar(_ par: UIView, now: String){
    let othersButton = createSomeButton(k: 1, col: .brown, title: "Friends", imageName: "others")
    let cameraButton = createSomeButton(k: 2, col: .brown, title: "Post", imageName: "camera")
    cameraButton.addTarget(UIViewController(), action: #selector(UIViewController.toPost), for: .touchUpInside)
    let homeButton = createSomeButton(k: 3, col: .brown, title: "Home", imageName: "home")
    homeButton.addTarget(UIViewController(), action: #selector(UIViewController.toHome), for: .touchUpInside)
    let mypageButton = createSomeButton(k: 4, col: .brown, title: "My Page", imageName: "mypage")
    let settingButton = createSomeButton(k: 5, col: .brown, title: "Setting", imageName: "setting")
    switch now {
    case "Home":
        homeButton.backgroundColor = colar(r: 102, g: 204, b: 51)
    case "Setting":
        settingButton.backgroundColor = colar(r: 102, g: 204, b: 51)
    case "Camera":
        cameraButton.backgroundColor = colar(r: 102, g: 204, b: 51)
    case "Others":
        othersButton.backgroundColor = colar(r: 102, g: 204, b: 51)
    case "Mypage":
        mypageButton.backgroundColor = colar(r: 102, g: 204, b: 51)
    default:
        return
    }
    par.addSubview(othersButton)
    par.addSubview(homeButton)
    par.addSubview(cameraButton)
    par.addSubview(mypageButton)
    par.addSubview(settingButton)
    par.insertSubview(othersButton, at: 1)
    par.insertSubview(homeButton, at: 1)
    par.insertSubview(cameraButton, at: 1)
    par.insertSubview(mypageButton, at: 1)
    par.insertSubview(settingButton, at: 1)
    //par.bringSubviewToFront(othersButton)
    //par.bringSubviewToFront(homeButton)
    //par.bringSubviewToFront(cameraButton)
    //par.bringSubviewToFront(mypageButton)
    //par.bringSubviewToFront(settingButton)
}

func createBottomBar(parentView par: UIView, controllerName name: controllerName) -> UILabel{
    let zBar = UILabel()
    let bw = CGFloat(4)
    zBar.setSize(w: yoko, h: tate / 9)
    let N = CGFloat(controllerName.allCases.count)
    let bDic: [String: UIButton] = [:]
    for key in controllerName.allCases{
        let name = key.imfo.0
        let n = CGFloat(key.imfo.1)
        let imageName = key.imfo.2
        let zButton = UIButton()
        zButton.setSize(w: zBar.ww / N - bw / 2, h: zBar.hh - bw / 2)
        zButton.setOrigin(x: zBar.ww / N * n, y: 0)
        setSubImage(parentView: zBar, rate: 0.5, imageName: imageName)
        let zLabel = UILabel()
        zLabel.setSize(w: zButton.ww, h: zButton.hh / 4)
        zLabel.setOrigin(x: 0, y: 0)
        zLabel.text = name
        zLabel.textColor = .white
        zLabel.textAlignment = NSTextAlignment.center
        //bDic[name] = zButton
    }
    return zBar
    }
    

class aaButton: UIButton {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.animationTouchBegan()
    }
    
    private func animationTouchBegan(){
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)}, completion: nil)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.animationTouchEnded()
    }
    
    private func animationTouchEnded(){
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)}, completion: nil)
    }

}

class ccButton: UIButton {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.animationTouchBegan()
    }
    
    private func animationTouchBegan(){
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {self.alpha = 0.65}, completion: nil)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.animationTouchEnded()
    }
    
    private func animationTouchEnded(){
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {self.alpha = 1}, completion: nil)
    }

}

extension UIView{
    func setRate(_ refView: UIView){
        let h = refView.bounds.size.height
        let w = refView.bounds.size.width
        if w == 0{
            return
        }else{
            let rate = h / w
            self.bounds.size.height = self.bounds.size.width * rate
        }
    }
    
    func setCenter(_ sub: UIView){
        self.addSubview(sub)
        let w = sub.bounds.size.width
        let h = sub.bounds.size.height
        sub.frame.origin.x = self.bounds.width / 2 - w / 2
        sub.frame.origin.y = self.bounds.height / 2 - h / 2
    }

    var ww: CGFloat{
        get{bounds.size.width}
        set{bounds.size.width = newValue}
    }
    var hh: CGFloat{
        get{bounds.size.height}
        set{bounds.size.height = newValue}
    }
    
    var size: CGSize{
        get{bounds.size}
        set{bounds.size = newValue}
    }
    
    var xx: CGFloat{
        get{frame.origin.x}
        set{frame.origin.x = newValue}
    }
    var yy: CGFloat{
        get{frame.origin.y}
        set{frame.origin.y = newValue}
    }
    
    var oo: CGPoint{
        get{frame.origin}
        set{frame.origin = newValue}
    }
    
    func setAll(par: UIView, w: CGFloat, h: CGFloat, x: CGFloat, y: CGFloat){
        par.addSubview(par)
        self.ww = w
        self.hh = h
        self.xx = x
        self.yy = y
    }

    func setAll(w: CGFloat, h: CGFloat, x: CGFloat, y: CGFloat){
        self.ww = w
        self.hh = h
        self.xx = x
        self.yy = y
    }
    
    func setSize(w: CGFloat, h: CGFloat){
        self.ww = w
        self.hh = h
    }
    
    func setOrigin(x: CGFloat, y: CGFloat){
        self.xx = x
        self.yy = y
    }
}




