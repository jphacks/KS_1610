//
//  MainViewController.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

/*
 let view:UIView  = UINib(nibName: "StampButtonView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
 view.frame = menuView.bounds
 view.translatesAutoresizingMaskIntoConstraints = true
 view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
 menuView.addSubview(view)
 */

class MainViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    fileprivate var _peer: SKWPeer?
    fileprivate var _data: SKWDataConnection?
    fileprivate var _id: String? = nil
    fileprivate var _bEstablished: Bool = false
    fileprivate var _listPeerIds: Array<String> = []
    
    private var myID: String = ""
    var timer: Timer!
    let audioPlay = AudioPlay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        webRTC()
        //        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: Selector(("onTimer:")), userInfo: nil, repeats: true)
        
        let view:UIView  = UINib(nibName: "StartUpView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = mainView.bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        mainView.addSubview(view)
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
            //            self.updateUI()
        })
    }
    
    func setDataCallbacks(_ data: SKWDataConnection) {
        
        // DataConnection opened
        data.on(SKWDataConnectionEventEnum.DATACONNECTION_EVENT_OPEN, callback: { (obj: NSObject?) -> Void in
            self._bEstablished = true;
            self.alertView(title: "P2P接続", message: "接続に成功しました", buttonName: "OK")
        })
        
        // Partber message
        data.on(SKWDataConnectionEventEnum.DATACONNECTION_EVENT_DATA, callback: { (obj: NSObject?) -> Void in
            let strValue: String = obj as! String
            self.alertView(title: "受信", message: strValue, buttonName: "OK")
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
        //        self.updateUI()
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
            alertView(title: "送信成功", message: "文字列の送信に成功しました", buttonName: "OK")
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
    
    func onTImer(sender: Timer) {
        //        if _bEstablished {
        //            self.send("OK??")
        //        }
        
//                if _data == nil {
//                    self.getPeerList()
//                } else {
//                    self.performSelector(inBackground: #selector(CreateRoomViewController.close), with: nil)
//                }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}

extension MainViewController {
    func onHomeMakeRoom(sender: UIButton) {
        let view:UIView  = UINib(nibName: "CreateRoomView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = mainView.bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        mainView.addSubview(view)
    }
    
    func onHomeEnterRoom(sender: UIButton) {
        let view:UIView  = UINib(nibName: "EnterRoomView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = mainView.bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        mainView.addSubview(view)
    }
    
    func onMakrRoom(sender: UIButton) {
        let view:UIView  = UINib(nibName: "WaitTimeView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = mainView.bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        mainView.addSubview(view)
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
        // timer.fire()
    }
    
    func onEnterRoom(sender: UIButton) {
        let view:UIView  = UINib(nibName: "WaitTimeView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = mainView.bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        mainView.addSubview(view)
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
        // timer.fire()
    }
    
    func onFight(sender: UIButton) {
        let view:UIView  = UINib(nibName: "StampButtonView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = mainView.bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        mainView.addSubview(view)
        
        var audioPlayDelegate: AudioPlayDelegate? = nil
        audioPlayDelegate = audioPlay
        audioPlayDelegate?.setAudio(audioName: "bgm_01")
        audioPlayDelegate?.audioPlay(needsLoop: true)
    }
    
    
    func onInputID(sender: UIButton) {
        if _data == nil {
            self.getPeerList()
        } else {
            self.performSelector(inBackground: #selector(MainViewController.close), with: nil)
        }
    }
    
    func onReturn(sender: UIButton) {
    
    }
    
    func update(tm: Timer) {
        let view:UIView  = UINib(nibName: "WakeUpView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = mainView.bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        mainView.addSubview(view)
        
        var audioPlayDelegate: AudioPlayDelegate? = nil
        audioPlayDelegate = audioPlay
        audioPlayDelegate?.setAudio(audioName: "bgm_01")
        audioPlayDelegate?.audioPlay(needsLoop: true)
    }
}
