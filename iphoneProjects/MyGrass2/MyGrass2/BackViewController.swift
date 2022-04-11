//
//  BackViewController.swift
//  MyGrass2
//
//  Created by 目黒丈一郎 on 2021/04/04.
//

import UIKit

class BackViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        titleviewcontroller.modalPresentationStyle = .fullScreen
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleviewcontroller.modalPresentationStyle = .fullScreen
        backviewcontroller.present(titleviewcontroller, animated: false, completion: {print("presenttitle")})
    }
}
