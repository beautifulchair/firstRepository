//
//  startViewControlle.swift
//  MyGrass2
//
//  Created by 目黒丈一郎 on 2021/02/20.
//

import UIKit

class startViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
        
        
        
    }
    
    let titleLabel: UILabel = {
        let view = UILabel.init()
        view.text = "My Grass"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}
