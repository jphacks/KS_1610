//
//  MainViewController.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//
import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    var _peer: SKWPeer?
    var _data: SKWDataConnection?
    var _id: String? = nil
    var _bEstablished: Bool = false
    var _listPeerIds: Array<String> = []
    
    var myID: String = ""
    var timer: Timer!
    var endTimer: Timer!
    let audioPlay = AudioPlay()
    let stampAudioPlay: [AudioPlay] = [AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay()]
    var stampAaudioPlayerCount: Int = 0
    var myFight: Bool = false
    var youFight: Bool = false
    var nowPage: String = "Home"
    
    let userDefault = UserDefaults.standard
    let format = DateFormatter()
    var setTime: String = ""
    var canTimer: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webRTC()
        
        pagingView(selfNib: "", nibName: "StartUpView")
    }
    
    func alertView(title: String, message: String, buttonName: String){
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonAction = UIAlertAction(title: buttonName, style: .default) { action in
            
        }
        alert.addAction(buttonAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController {
    
    
    func update(tm: Timer) {
        format.dateFormat = "HH:mm"
        let nowTime: String = format.string(from: NSDate() as Date)
        
        if (nowTime == setTime) && canTimer {
            canTimer = false // 再度するときはリセット必要
            
            pagingView(selfNib: "", nibName: "WakeUpView")
            
            var audioPlayDelegate: AudioPlayDelegate? = nil
            audioPlayDelegate = audioPlay
            audioPlayDelegate?.setAudio(audioName: "bgm_01")
            audioPlayDelegate?.audioPlay(needsLoop: true)
        }
    }
    
    func end(){
        if self.myFight {
            pagingView(selfNib: "", nibName: "ClearView")
            audioPlay.audioStop()
        }
    }
    
    func stampAudio(name: String){
        let audioPlayDelegate: AudioPlayDelegate? = stampAudioPlay[stampAaudioPlayerCount]
        if stampAudioPlay.count == (stampAaudioPlayerCount + 1) {
            stampAaudioPlayerCount = 0
        }else{
            stampAaudioPlayerCount += 1
        }
        audioPlayDelegate?.setAudio(audioName: name)
        audioPlayDelegate?.audioPlay(needsLoop: false)
    }
}

extension MainViewController {
    func pagingView(selfNib: String, nibName: String) {
        nowPage = nibName
        let view:UIView  = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = mainView.bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        removeAllSubviews(parentView: mainView)
        mainView.addSubview(view)
    }
    
    
    func removeAllSubviews(parentView: UIView){
        let subviews = parentView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}
