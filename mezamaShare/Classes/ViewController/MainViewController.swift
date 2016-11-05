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
    fileprivate var _peer: SKWPeer?
    fileprivate var _data: SKWDataConnection?
    fileprivate var _id: String? = nil
    fileprivate var _bEstablished: Bool = false
    fileprivate var _listPeerIds: Array<String> = []
    
    private var myID: String = ""
    var timer: Timer!
    var endTimer: Timer!
    let audioPlay = AudioPlay()
    let stampAudioPlay: [AudioPlay] = [AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay()]
    var stampAaudioPlayerCount: Int = 0
    var myFight: Bool = false
    var youFight: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webRTC()
        
        pagingView(selfNib: "", nibName: "StartUpView")
    }
    
    func webRTC() {
        let option: SKWPeerOption = SKWPeerOption.init()
        option.key = "ae7068ea-8871-45c3-b157-23be59c73d5f"
        option.domain = "akkeylab"
        _peer = SKWPeer.init(options: option)
        
        _peer?.on(SKWPeerEventEnum.PEER_EVENT_ERROR, callback: { (obj: NSObject?) -> Void in
            let error: SKWPeerError = obj as! SKWPeerError
            self.alertView(title: "Error", message: String(describing: error), buttonName: "OK")
        })
        
        _peer?.on(SKWPeerEventEnum.PEER_EVENT_OPEN, callback: { (obj: NSObject?) -> Void in
            self._id = obj as? String
            DispatchQueue.main.async(execute: {
                self.myID = self._id!
                self.alertView(title: "Get my ID", message: self.myID, buttonName: "OK")
            })
        })
        
        _peer?.on(SKWPeerEventEnum.PEER_EVENT_CONNECTION, callback: { (obj: NSObject?) -> Void in
            self._data = obj as? SKWDataConnection
            self.setDataCallbacks(self._data!)
            self._bEstablished = true
        })
    }
    
    func setDataCallbacks(_ data: SKWDataConnection) {
        
        // DataConnection opened
        data.on(SKWDataConnectionEventEnum.DATACONNECTION_EVENT_OPEN, callback: { (obj: NSObject?) -> Void in
            self._bEstablished = true
            self.alertView(title: "P2P接続", message: "接続に成功しました", buttonName: "OK")
        })
        
        // Partber message
        data.on(SKWDataConnectionEventEnum.DATACONNECTION_EVENT_DATA, callback: { (obj: NSObject?) -> Void in
            let strValue: String = obj as! String
            NSLog("\(strValue)")
            
            if strValue == "onFight" {
                self.youFight = true
                
            }else if strValue == "end" {
                DispatchQueue.main.async { self.end() }
                
            }else{
                self.stampAudio(name: strValue)
            }
        })
        
        // DataConnection closed
        data.on(SKWDataConnectionEventEnum.DATACONNECTION_EVENT_CLOSE, callback: { (obj: NSObject?) -> Void in
            self._data = nil
            self._bEstablished = false
            self.alertView(title: "P2P切断", message: "接続が終了しました", buttonName: "OK")
        })
    }
    
    func getPeerList() {
        if (_peer == nil) || (_id == nil) || (_id?.characters.count == 0) {
            return
        }
        
        _peer?.listAllPeers({ (peers: [Any]?) -> Void in
            self._listPeerIds = []
            let peersArray: [String] = peers as! [String]
            for strValue: String in peersArray {
                print(strValue)
                
                if strValue == self._id {
                    continue
                }
                self._listPeerIds.append(strValue)
            }
            if self._listPeerIds.count > 0 {
                self.showPeerDialog()
            }
        })
    }
    
    func connect(_ strDestId: String) {
        let options = SKWConnectOption()
        options.label = "chat"
        options.metadata = "{'message': 'hi'}"
        options.serialization = SKWSerializationEnum.SERIALIZATION_BINARY
        options.reliable = true
        
        _data = _peer?.connect(withId: strDestId, options: options)
        setDataCallbacks(self._data!)
    }
    
    func close() {
        if _bEstablished == false {
            return
        }
        _bEstablished = false
        
        if _data != nil {
            _data?.close()
        }
    }
    
    func send(_ data: String) {
        let bResult: Bool = (_data?.send(data as NSObject!))!
        
        if bResult == true {
//            alertView(title: "送信成功", message: "文字列の送信に成功しました", buttonName: "OK")
        }
    }
    
    func showPeerDialog() {
        let vc: PeerListForDataViewController = PeerListForDataViewController()
        vc.items = _listPeerIds as [AnyObject]?
        vc.callback = self
        
        let nc: UINavigationController = UINavigationController.init(rootViewController: vc)
        
        DispatchQueue.main.async(execute: {
            self.present(nc, animated: true, completion: nil)
        })
    }
    
    @IBAction func pushCallButton(_ sender: AnyObject) {
        if _data == nil {
            self.getPeerList()
        } else {
            self.performSelector(inBackground: #selector(MainViewController.close), with: nil)
        }
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
    func onHomeMakeRoom(sender: UIButton) {
        pagingView(selfNib: "", nibName: "CreateRoomView")
    }
    
    func onHomeEnterRoom(sender: UIButton) {
        if _bEstablished {
            pagingView(selfNib: "", nibName: "EnterRoomView")
        }else{
            alertView(title: "接続未完了", message: "接続を完了させてください", buttonName: "OK")
        }
    }
    
    func onMakrRoom(sender: UIButton) {
        if _bEstablished {
            pagingView(selfNib: "", nibName: "WaitTimeView")
            timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
        }else{
            alertView(title: "接続未完了", message: "メンバーが接続するまでお待ち下さい", buttonName: "OK")
        }
    }
    
    func onEnterRoom(sender: UIButton) {
        pagingView(selfNib: "", nibName: "WaitTimeView")
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
    }
    
    func onFight(sender: UIButton) {
        myFight = true
        send("onFight")
        
        if youFight {
            pagingView(selfNib: "", nibName: "ClearView")
            
            self.audioPlay.audioStop()
            self.send("end")
        } else {
            pagingView(selfNib: "", nibName: "StampButtonView")
            
            var audioPlayDelegate: AudioPlayDelegate? = nil
            audioPlayDelegate = audioPlay
            audioPlayDelegate?.setAudio(audioName: "bgm_01")
            audioPlayDelegate?.audioPlay(needsLoop: true)
        }
    }
    
    func onInputID(sender: UIButton) {
        NSLog("onInputID")
        if _data == nil {
            self.getPeerList()
        } else {
            self.performSelector(inBackground: #selector(MainViewController.close), with: nil)
        }
    }
    
    func onReturn(sender: UIButton) {
        NSLog("onReturn")
    
    }
    
    func update(tm: Timer) {
        pagingView(selfNib: "", nibName: "WakeUpView")
        
        var audioPlayDelegate: AudioPlayDelegate? = nil
        audioPlayDelegate = audioPlay
        audioPlayDelegate?.setAudio(audioName: "bgm_01")
        audioPlayDelegate?.audioPlay(needsLoop: true)
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

extension MainViewController{
    func onTapButton1(sender: UIButton) {
        send("mezamashare_zugyuuuun")
        stampAudio(name: "mezamashare_zugyuuuun")
    }
    
    func onTapButton2(sender: UIButton) {
        send("mezamashare_ppap4")
        stampAudio(name: "mezamashare_ppap4")
    }
    
    func onTapButton3(sender: UIButton) {
        send("mezamashare_okiro")
        stampAudio(name: "mezamashare_okiro")
    }
    
    func onTapButton4(sender: UIButton) {
        send("mezamashare_sukida")
        stampAudio(name: "mezamashare_sukida")
    }
    
    func onTapButton5(sender: UIButton) {
//        send("")
    }
    
    func onTapButton6(sender: UIButton) {
//        send("")
    }
}

extension MainViewController {
    func pagingView(selfNib: String, nibName: String) {
        NSLog("Paging by \(nibName)")
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
