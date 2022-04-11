//
//  ViewController.swift
//  yopparaicheck1
//
//  Created by 目黒丈一郎 on 2021/09/29.
//

import UIKit

class ViewController: UIViewController {
    
    let buttonz = aaButton()
    let buttonOpen = aaButton()
    var questionLabel = UILabel()
    
    @objc func openLine(){
        if UIApplication.shared.canOpenURL(lineurl!){
            UIApplication.shared.open(lineurl!, options: [:], completionHandler: nil)
        }
    }
    
    @objc func startQuestion(){
        let question = questionList.randomElement()
        question?.visualize(view)
        question?.questionLabel.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        buttonz.set(view, widthRate: 0.7, heightRate: 0.1, xRate: 0.5, yRate: 0.5)
        buttonz.backgroundColor = .blue
        buttonz.addTarget(self, action: #selector(startQuestion), for: .touchDown)
        
        //buttonOpen.set(view, widthRate: 0.7, heightRate: 0.1, xRate: 0.5, yRate: 0.7)
        //buttonOpen.backgroundColor = .green
        //buttonOpen.addTarget(self, action: #selector(openLine), for: .touchDown)
    }


}

