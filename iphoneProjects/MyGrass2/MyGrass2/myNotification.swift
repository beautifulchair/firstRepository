//
//  myNotification.swift
//  MyGrass2
//
//  Created by 目黒丈一郎 on 2021/03/07.
//

import Foundation

class CameraNotification{
    class CameraPoster{
        static var nM = Notification.Name("cameraNotification")
        func post(){
            NotificationCenter.default.post(name: Self.nM, object: nil)
        }
    }

    class CameraObserver{
        init() {
            NotificationCenter.default.addObserver(self, selector: #selector(Self.hN(_:)), name: CameraPoster.nM, object: nil)
        }
        
        deinit{
            NotificationCenter.default.removeObserver(self)
        }
        
        @objc static func hN(_ notificaton: Notification){
            
        }
    }
}




