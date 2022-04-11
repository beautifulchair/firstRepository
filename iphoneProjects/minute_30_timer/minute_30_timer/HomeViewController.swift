//
//  HomeViewController.swift
//  minute_30_timer
//
//  Created by 目黒丈一郎 on 2021/09/09.
//

import UIKit
import AudioToolbox

class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let w_label = CGFloat(yoko * 0.618)
    let h_label = CGFloat(yoko * 0.19)
    let label_m = UILabel()
    let label_d = UILabel()
    let button_reset = aaButton()
    let button_start = aaButton()
    let button_change = aaButton()
    let progressz = UIProgressView()
    let button_add = aaButton()
    let button_sub = aaButton()
    let button_add_ten = aaButton()
    let button_sub_ten = aaButton()
    let settingImage = UIImage(named: "setting")
    let changeImage = UIImage(named: "change_gray2")
    var minute = Int(1)
    var percent = Float(0)
    var second = Int(0)
    var timerz = Timer()
    var mtimer = Timer()
    var guruguru = UIActivityIndicatorView()
    lazy var buttons = [button_add, button_sub, button_add_ten, button_sub_ten]
    var dFlag =  Bool(true)
    let button_setting = aaButton()
    let setting_view = UIView()
    let button_back = aaButton()
    let button_d = aaButton()
    let list_sound = ["1", "2", "3", "4"]
    let list_color = ["yellow", "red", "blue", "green", "gray", "black"]
    let picker_sound = UIPickerView()
    let picker_color = UIPickerView()
    let slider_width = UISlider()
    let switch_sound = UISwitch()
    let label_setting_sound = UILabel()
    let label_setting_color = UILabel()
    let label_setting_width = UILabel()
    let label_setting_soundonoff = UILabel()
    let dic_sound:[String: Int] =  ["1": 1000, "2": 1005, "3": 1008, "4": 1010]
    let dic_color:[String: UIColor] = ["yellow": .systemYellow, "red": .systemRed, "blue": .systemBlue, "green": .systemGreen, "gray": .systemGray, "black": .black]
    
    var sound_type = String("1")
    var sound_onoff =  Bool(true)
    var viblation_onoff = Bool(true)
    var colorstr = String("yellow")
    var barcolor = UIColor.systemYellow
    var barwidthrate = CGFloat(3)
    var wText: String{return String(format: "%.1f", Float(barwidthrate))}
    
    var dText: String {
        if dFlag{
            if second >= 3600 {return String(format: "%d h %d m %d s", second / 3600, second % 3600 / 60, second % 60)}
            else if second >= 60 {return String(format: "%d m %d s", second / 60, second % 60)}
            else {return String(format: "%d s", second)}
        }
        else {return String(format: "%.2f", percent * 100) + " %"}
    }
    var onoffText: String{
        if sound_onoff{return String("sound: ON")}
        else{return "sound: OFF"}
    }
    var colorText: String{return String(format: "bar color: %@", colorstr)}
    var soundText: String{return String(format: "sound type: %@", sound_type)}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.setSub(label_m, w_label, h_label, 0.5, 0.2)
        label_m.backgroundColor = .systemGray
        //label_m.text = String(minute) + " m"
        label_m.textAlignment = .center
        label_m.textColor = .white
        
        view.setSub(button_add, h_label * 0.7, h_label * 0.42, 0.9, 0.175)
        button_add.backgroundColor = .systemGray
        button_add.setTitle("+", for: .normal)
        button_add.setTitleColor(.white, for: .normal)
        button_add.setTitleColor(.yellow, for: .highlighted)
        button_add.addTarget(self, action: #selector(self.add), for: .touchUpInside)
        
        view.setSub(button_add_ten, h_label * 0.7, h_label * 0.42, 0.9, 0.225)
        button_add_ten.backgroundColor = .systemGray
        button_add_ten.setTitle("+10", for: .normal)
        button_add_ten.setTitleColor(.white, for: .normal)
        button_add_ten.setTitleColor(.yellow, for: .highlighted)
        button_add_ten.addTarget(self, action: #selector(self.addten), for: .touchUpInside)
        
        view.setSub(button_sub, h_label * 0.7, h_label * 0.42, 0.1, 0.175)
        button_sub.backgroundColor = .systemGray
        button_sub.setTitle("-", for: .normal)
        button_sub.setTitleColor(.white, for: .normal)
        button_sub.setTitleColor(.yellow, for: .highlighted)
        button_sub.addTarget(self, action: #selector(self.sub), for: .touchUpInside)
        
        view.setSub(button_sub_ten, h_label * 0.7, h_label * 0.42, 0.1, 0.225)
        button_sub_ten.backgroundColor = .systemGray
        button_sub_ten.setTitle("-10", for: .normal)
        button_sub_ten.setTitleColor(.white, for: .normal)
        button_sub_ten.setTitleColor(.yellow, for: .highlighted)
        button_sub_ten.addTarget(self, action: #selector(self.subten), for: .touchUpInside)
        
        view.setSub(label_d, w_label, h_label, 0.5, 0.4)
        label_d.backgroundColor = .systemGray
        //label_d.text = dText
        label_d.textAlignment = .center
        label_d.textColor = .white
        
        view.setSub(button_change, h_label * 0.4, h_label * 0.4, 0.1, 0.4)
        button_change.addTarget(self, action: #selector(self.change), for: .touchUpInside)
        
        button_change.fitSub(UIImageView(image: changeImage))
        
        view.setSub(button_reset, w_label, h_label, 0.5, 0.7)
        button_reset.backgroundColor = .systemGray
        button_reset.setTitle("reset", for: .normal)
        button_reset.setTitleColor(.white, for: .normal)
        button_reset.setTitleColor(.yellow, for: .highlighted)
        button_reset.layer.cornerRadius = 20
        button_reset.addTarget(self, action: #selector(self.reset), for: .touchUpInside)
        
        view.setSub(button_start, w_label, h_label, 0.5, 0.9)
        button_start.backgroundColor = .systemGray
        button_start.setTitle("start", for: .normal)
        button_start.setTitleColor(.white, for: .normal)
        button_start.setTitleColor(.yellow, for: .highlighted)
        button_start.layer.cornerRadius = 20
        button_start.addTarget(self, action: #selector(self.startstop), for: .touchUpInside)
        
        view.setSub(progressz, w_label * 1.2, h_label * 0.1, 0.5, 0.55)
        progressz.transform = CGAffineTransform(scaleX: 1, y: 0.5 * barwidthrate)
        progressz.backgroundColor = .systemGray
        progressz.progressTintColor = .systemYellow
        //progressz.layer.cornerRadius = 4
        
        view.setSub(guruguru, h_label*0.42, h_label*0.42, 0.5, 0.6)
        guruguru.color = .systemGray
        
        view.setSub(button_setting, h_label * 0.8, h_label * 0.8, 0.15, 0.1)
        //button_setting.setTitle("setting", for: .normal)
        button_setting.setTitleColor(.systemGray, for: .normal)
        button_setting.setTitleColor(.yellow, for: .highlighted)
        button_setting.layer.cornerRadius = 20
        button_setting.addTarget(self, action: #selector(self.toSetting), for: .touchUpInside)
        
        button_setting.fitSub(UIImageView(image: settingImage), rate: 0.8)
        
        view.setSub(setting_view, yoko * 0.8, tate * 0.8, 0.5, 0.5)
        setting_view.backgroundColor = .white
        setting_view.alpha = 0.98
        setting_view.layer.cornerRadius = 20
        setting_view.layer.borderWidth = 5
        setting_view.layer.borderColor = UIColor.gray.cgColor
        setting_view.isHidden = true
        
        setting_view.setSub(label_setting_width, w_label * 0.8, h_label * 0.8, 0.5, 0.1)
        label_setting_width.backgroundColor = .gray
        //label_setting_width.text = wText
        label_setting_width.textColor = .white
        label_setting_width.textAlignment = .center
        
        setting_view.setSub(slider_width, w_label * 0.8, h_label * 0.2, 0.5, 0.2)
        slider_width.minimumValue = 1
        slider_width.maximumValue = 20
        slider_width.value = Float(barwidthrate)
        slider_width.addTarget(self, action: #selector(slider), for: .valueChanged)
        
        setting_view.setSub(label_setting_soundonoff, w_label * 0.8, h_label * 0.8, 0.5, 0.3)
        label_setting_soundonoff.backgroundColor = .gray
        //label_setting_soundonoff.text = onoffText
        label_setting_soundonoff.textColor = .white
        label_setting_soundonoff.textAlignment = .center
        
        setting_view.setSub(switch_sound, w_label * 0.8 * 0.4, w_label * 0.8 * 0.2, 0.5, 0.4)
        switch_sound.isOn = true
        switch_sound.addTarget(self, action: #selector(switchsound), for: .valueChanged)
        
        setting_view.setSub(label_setting_sound, w_label * 0.8, h_label * 0.8, 0.5, 0.5)
        label_setting_sound.backgroundColor = .gray
        //label_setting_sound.text = soundText
        label_setting_sound.textColor = .white
        label_setting_sound.textAlignment = .center
        
        setting_view.setSub(picker_sound, w_label * 0.8, h_label * 0.8, 0.5, 0.6)
        picker_sound.delegate = self
        picker_sound.dataSource = self
        
        setting_view.setSub(label_setting_color, w_label * 0.8, h_label * 0.8, 0.5, 0.7)
        label_setting_color.backgroundColor = .gray
        //label_setting_color.text = colorText
        label_setting_color.textColor = .white
        label_setting_color.textAlignment = .center
        
        setting_view.setSub(picker_color, w_label * 0.8, h_label * 0.8, 0.5, 0.8)
        picker_color.delegate = self
        picker_color.dataSource = self
        
        setting_view.setSub(button_back, w_label * 0.8, h_label * 0.8, 0.5, 0.9)
        button_back.backgroundColor = .systemGray
        button_back.setTitle("back", for: .normal)
        button_back.setTitleColor(.white, for: .normal)
        button_back.setTitleColor(.yellow, for: .highlighted)
        button_back.layer.cornerRadius = 20
        button_back.addTarget(self, action: #selector(self.back), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label_m.text = String(minute) + " m"
        label_d.text = dText
        label_setting_width.text = wText
        label_setting_soundonoff.text = onoffText
        label_setting_sound.text = soundText
        label_setting_color.text = colorText
    }
    
    @objc func startstop(){
        if timerz.isValid {
            timerz.invalidate()
            mtimer.invalidate()
            button_start.setTitle("start", for: .normal)
        } else{
            guruguru.startAnimating()
            buttons.forEach({$0.isEnabled = false})
            buttons.forEach({$0.alpha = 0.3})
            timerz = Timer.scheduledTimer(timeInterval: TimeInterval(Float(minute * 60) / Float(1000)), target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            mtimer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(self.mupdate), userInfo: nil, repeats: true)
            button_start.setTitle("stop", for: .normal)
        }
    }
    
    @objc func update(){
        if percent >= 1 {timeup()}
        label_d.text = dText
        percent += 0.001
        progressz.setProgress(percent , animated: false)
    }
    
    @objc func mupdate(){
        second += 1
        //label_d.text = dText
    }
    
    func timeup(){
        percent = 0
        second = 0
        print(#function)
        if sound_onoff {AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)}
        if viblation_onoff {AudioServicesPlaySystemSound(SystemSoundID(dic_sound[sound_type]!))}
    }
    
    @objc func reset(){
        timerz.invalidate()
        mtimer.invalidate()
        guruguru.stopAnimating()
        buttons.forEach({$0.isEnabled = true})
        buttons.forEach({$0.alpha = 1.0})
        percent = 0
        second = 0
        label_d.text = dText
        button_start.setTitle("start", for: .normal)
        progressz.setProgress(percent , animated: true)
    }
    
    @objc func add(){
        minute += 1
        if minute > 120 {
            minute = 120
            let generator = UINotificationFeedbackGenerator()
            if viblation_onoff {generator.notificationOccurred(.error)}
        }
        label_m.text = String(minute) + " m"
        let generator = UINotificationFeedbackGenerator()
        if viblation_onoff {generator.notificationOccurred(.success)}
    }
    
    @objc func sub(){
        minute -= 1
        if minute < 0 {
            minute = 0
            let generator = UINotificationFeedbackGenerator()
            if viblation_onoff {generator.notificationOccurred(.error)}
        }
        label_m.text = String(minute) + " m"
        let generator = UINotificationFeedbackGenerator()
        if viblation_onoff {generator.notificationOccurred(.success)}
    }
    
    @objc func addten(){
        minute += 10
        if minute > 120 {
            minute = 120
            let generator = UINotificationFeedbackGenerator()
            if viblation_onoff {generator.notificationOccurred(.error)}
        }
        label_m.text = String(minute) + " m"
        let generator = UINotificationFeedbackGenerator()
        if viblation_onoff {generator.notificationOccurred(.success)}
    }
    
    @objc func subten(){
        minute -= 10
        if minute < 0 {
            minute = 0
            let generator = UINotificationFeedbackGenerator()
            if viblation_onoff {generator.notificationOccurred(.error)}
        }
        label_m.text = String(minute) + " m"
        let generator = UINotificationFeedbackGenerator()
        if viblation_onoff {generator.notificationOccurred(.success)}
    }
    
    @objc func toSetting(){
        setting_view.isHidden = false
    }
    
    @objc func change(){
        if dFlag {dFlag = false}
        else {dFlag = true}
        label_d.text = dText
    }
    
    @objc func slider(){
        barwidthrate = CGFloat(slider_width.value)
        progressz.transform = CGAffineTransform(scaleX: 1, y: 1 * barwidthrate)
        label_setting_width.text = wText
    }
    
    @objc func switchsound(){
        sound_onoff = switch_sound.isOn
        print(sound_onoff)
        label_setting_soundonoff.text = onoffText
    }
    
    @objc func back(){
        setting_view.isHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case picker_sound:
            return list_sound.count
        case picker_color:
            return list_color.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case picker_sound:
            return list_sound[row]
        case picker_color:
            return list_color[row]
        default:
            return "error"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case picker_sound:
            label_setting_sound.text = "sound: type" +  String(list_sound[row])
            if sound_onoff {AudioServicesPlaySystemSound(SystemSoundID(dic_sound[sound_type]!))}
            sound_type = list_sound[row]
            label_setting_sound.text = soundText
        case picker_color:
            label_setting_color.text = "bar color: " +  String(list_color[row])
            barcolor = dic_color[list_color[row]]!
            colorstr = list_color[row]
            progressz.progressTintColor = barcolor
            label_setting_color.text = colorText
        default:
            break
        }
    }
}
