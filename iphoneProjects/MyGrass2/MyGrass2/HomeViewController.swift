//
//  startViewController.swift
//  MyGrass2
//
//  Created by 目黒丈一郎 on 2021/02/20.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var lacationManager: CLLocationManager?
    var mapView: MKMapView?
    var locationManager: CLLocationManager?
    var textQButton = "??"
    var myLocationManager: CLLocationManager?
    var usingLocation = myHomeLocation
    internal var postviewcontroller = PostViewController()
    //
    //
    //
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.resetViewController()
        print("homeviewdidload")
        self.view.backgroundColor = .white
        
        myLocationManager = createLocationManager()
        checkStatus(lm: myLocationManager!)
        
        changeUsingLocation(coordinate: myLocationManager?.location?.coordinate)
        changeMapView(coordinate: usingLocation)
        
        let mapView = createMapView()
        self.view.addSubview(mapView)
        
        let reloadButton = createReloabutton()
        self.view.addSubview(reloadButton)
        
        let qButton = createQButton()
        self.view.addSubview(qButton)
        
        let menuButton = maruiButton(centerX: rr * 1.5, centerY: rr * 2.5)
        setSubImage(parentView: menuButton, rate: 0.5, imageName: "menu", ifround: true)
        self.view.addSubview(menuButton)
        
        //let plofileBar = createPlofileBar()
        //self.view.addSubview(plofileBar)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("homeviewdidappear")
        super.viewDidAppear(animated)
        setBottomBar(self.view, now: "Home")
    }
    
    //
    //
    //
    //
    
    func createPlofileBar() -> UILabel{
        let zLabel = UILabel()
        zLabel.bounds.size.width = yoko
        zLabel.bounds.size.height = tate / 10
        zLabel.frame.origin.x = 0
        zLabel.frame.origin.y = tate / 20
        zLabel.layer.borderWidth = 1
        zLabel.layer.borderColor = UIColor.brown.cgColor
        zLabel.backgroundColor = UIColor(red: 204/255, green: 153/255, blue: 102/255, alpha: 1)
        return zLabel
    }
    
    func changeUsingLocation(coordinate: CLLocationCoordinate2D?){
        usingLocation = coordinate ?? myHomeLocation
    }
    
    func changeMapView(coordinate: CLLocationCoordinate2D){
        mapView?.setCenter(coordinate, animated: true)
    }
    
    func createMapView() -> MKMapView{
        let zMapView = MKMapView()
        zMapView.frame = self.view.bounds
        zMapView.bounds.size.height = tate / 9 * 8
        zMapView.frame.origin.y = 0
        //zMapView.showsUserLocation = true
        zMapView.userTrackingMode = .followWithHeading
        //zMapView.setRegion(MKCoordinateRegion(center: usingLocation, latitudinalMeters: 100, longitudinalMeters: 100) , animated: true)
        return zMapView
    }
    
    func createLocationManager() -> CLLocationManager {
        let zLocationManager = CLLocationManager()
        zLocationManager.delegate = self
        zLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        return zLocationManager
    }
    
    func checkStatus(lm: CLLocationManager){
        if CLLocationManager.locationServicesEnabled(){
            let zStatus = lm.authorizationStatus
            print(zStatus.rawValue)
            switch zStatus{
            case .notDetermined:
                lm.requestWhenInUseAuthorization()
            case .denied, .restricted:
                onegai()
            case .authorizedAlways, .authorizedWhenInUse:
                lm.startUpdatingLocation()
            default:
                print("?????????????????")
            }
        }
    }
    
    func onegai(){
        print("onegai")
    }
    
    func createQButton() -> UIButton{
        let zButton = maruiButton(centerX: rr * 10.5, centerY: rr * 3)
        zButton.addTarget(self, action: #selector(self.doQButton), for: .touchUpInside)
        zButton.setTitleColor(.black, for: .normal)
        zButton.setTitle(textQButton, for: .normal)
        return zButton
    }
    
    func createReloabutton() -> UIButton{
        let zButton = maruiButton(centerX: rr * 10.5, centerY: rr * 20)
        setSubImage(parentView: zButton, rate: 0.7, imageName: "reload")
        zButton.backgroundColor = .gray
        zButton.alpha = 0.6
        zButton.layer.borderColor = UIColor.brown.cgColor
        zButton.addTarget(self, action: #selector(self.doReloadButton), for: .touchUpInside)
        return zButton
    }
    
    @objc func doReloadButton(){
        viewDidLoad()
    }
    
    @objc func doQButton(){
        if countQButton == 1 {
            countQButton = 0
            textQButton = "OFF"
        }else{
            countQButton = 1
            textQButton = "ON"
        }
        self.viewDidLoad()
    }
    
}
