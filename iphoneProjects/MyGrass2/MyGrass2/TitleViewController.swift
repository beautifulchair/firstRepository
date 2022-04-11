//
//  titleViewController.swift
//  MyGrass2
//
//  Created by 目黒丈一郎 on 2021/02/20.
//

import UIKit
import MapKit
import CoreLocation

class TitleViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 1, blue: 204/255, alpha: 1)
        //setBottomBar(self.view, now: "Home")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("titledidappear")
        let titleLabel = UILabel()
        setSub(sub: titleLabel, parentView: self.view, rate: 0.2)
        let im = returnImageview(imageName: "title")
        setSub(sub: im , parentView: titleLabel, rate: 0.8)
        im.bounds.size.width = im.bounds.size.width * 1.5
        titleLabel.alpha = 0
        UIView.animate(withDuration: 1.8, delay: 0.4, options: [.curveEaseIn], animations: {titleLabel.alpha = 1}, completion: {_ in
            UIView.animate(withDuration: 2.0, delay: 0.6, animations: {titleLabel.alpha = 0}, completion: {_ in
                homeviewcontroller.modalPresentationStyle = .fullScreen
                self.present(homeviewcontroller, animated: false, completion: nil)
            })
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}


