//
//  CameraViewController.swift
//  MyGrass2
//
//  Created by 目黒丈一郎 on 2021/02/27.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    var mySession: AVCaptureSession?
    var myMainCamera: AVCaptureDevice?
    var myInnerCamera: AVCaptureDevice?
    var myCurrentCamera: AVCaptureDevice?
    var myInput: AVCaptureDeviceInput?
    var myOutput: AVCapturePhotoOutput?
    var myPreview: AVCaptureVideoPreviewLayer?
    var mySetting: AVCapturePhotoSettings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        setupCamera()
        
        let shutterButton = maruiButton(centerX: yoko / 2, centerY: tate / 10 * 8)
        shutterButton.addTarget(self, action: #selector(getPhoto), for: .touchUpInside)
        self.view.addSubview(shutterButton)
    }
    
    func setSession(){
        mySession = AVCaptureSession()
        mySession?.sessionPreset = .high
    }
    
    func setCamera(){
        myCurrentCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    }
    
    func setInput(){
        do{
            myInput = try AVCaptureDeviceInput(device: myCurrentCamera!)
            mySession?.addInput(myInput!)
        }catch{
            print(error)
        }
    }
    
    func setOutput(){
        myOutput = AVCapturePhotoOutput()
        myOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        mySession?.addOutput(myOutput!)
    }
    
    func setPreview(){
        myPreview = AVCaptureVideoPreviewLayer(session: mySession!)
        myPreview?.videoGravity = .resize
        self.view.layer.addSublayer(myPreview!)
        myPreview?.position = CGPoint(x: yoko / 2, y: tate / 2 - 5)
        
        myPreview?.bounds.size.width = yoko - 10
        myPreview?.bounds.size.height = tate - 10
    }
    
    @objc func getPhoto(){
        mySetting = AVCapturePhotoSettings()
        mySetting?.flashMode = .off
        mySetting?.isHighResolutionPhotoEnabled = false
        myOutput?.capturePhoto(with: mySetting!, delegate: self)
        Thread.sleep(forTimeInterval: 0.2)
        self.dismiss(animated: true, completion: nil)
    }
    
    //wakaranai
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let zImageData = photo.fileDataRepresentation() {
                let zImage = UIImage(data: zImageData)
                nowPhoto = zImage
                //setSub(sub: UIImageView(image: nowPhoto), parentView: postviewcontroller.photoButton!, rate: 1)
                print("nnnnnnnnn")
                print(nowPhoto)
            }
        }
    
    func setupCamera(){
        setSession()
        guard let _ = mySession else {return}
        setCamera()
        guard let _ = myCurrentCamera else {return}
        setInput()
        setOutput()
        setPreview()
        mySession?.startRunning()
    }
    
    
    
    
}
