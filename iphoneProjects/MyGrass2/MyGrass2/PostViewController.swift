//
//  PostViewController.swift
//  MyGrass2
//
//  Created by 目黒丈一郎 on 2021/03/01.
//

import UIKit

class PostViewController: UIViewController{
    
    var photoButton: UIButton?
    var photoView: UIImageView?
    var plusButton: UIButton?
    var titleField: UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetViewController()
        self.view.backgroundColor = .white
        self.view.hh = tate * 8 / 9
        setBottomBar(self.view, now: "Post")
        
        let reloadButton = maruiButton(centerX: rr * 5, centerY: rr * 5)
        reloadButton.addTarget(self, action: #selector(self.resetAndReload), for: .touchUpInside)
        fitSub(sub: reloadButton, par: self.view)
        reloadButton.frame.origin.y = tate - 2 * rr
        
        let photoButton = ccButton()
        //photoButton.backgroundColor = .gray
        photoButton.addTarget(self, action: #selector(UIViewController.toCamera), for: .touchUpInside)
        self.view.addSubview(photoButton)
        photoButton.frame.origin.x = yoko / 2
        photoButton.frame.origin.y = tate / 2
        photoButton.layer.borderWidth = 2
        photoButton.layer.borderColor = UIColor.black.cgColor
        photoButton.bounds.size.height = photoSize.height
        photoButton.bounds.size.width = photoSize.width
        print("rrrrrr")
        print(nowPhoto)
        if let _ = nowPhoto{
            let photoView = UIImageView(image: nowPhoto)
            photoView.bounds.size = photoButton.bounds.size
            photoButton.addSubview(photoView)
            photoView.frame.origin = CGPoint(x: 0, y: 0)
            print("ok")
            print(nowPhoto)
        }else{
            let plusButton = maruiButton(rad: rr * 0.75, centerX: 0, centerY: 0)
            plusButton.layer.borderWidth = 0
            plusButton.addTarget(self, action: #selector(self.toCamera), for: .touchUpInside)
            setSubImage(parentView: plusButton, rate: 1, imageName: "plus", ifround: true)
            photoButton.setCenter(plusButton)
            print("no")
        }
        
        let titleField = UITextField()
        titleField.backgroundColor = .green
        titleField.placeholder = "title"
        titleField.borderStyle = .roundedRect
        titleField.keyboardType = .asciiCapable
        titleField.returnKeyType  = .done
        titleField.clearButtonMode = .always
        fityoko(sub: titleField, parentView: self.view)
        titleField.frame.origin.y = rr * 2
        titleField.bounds.size.height = rr * 2
        titleField.bounds.size.width = yoko * 4 / 6
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(false)
        setBottomBar(self.view, now: "Camera")
    }

}
