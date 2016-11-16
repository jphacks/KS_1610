//
//  SkyWayController.swift
//  mezamaShare
//
//  Created by AKIO on 2016/11/06.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//
import UIKit

extension MainViewController {
    
    // WebRTC init function.
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
                // Get my id and save.
                self.userDefault.set(self._id!, forKey: "myID")
                self.userDefault.synchronize()
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
        })
        
        // Partber message
        data.on(SKWDataConnectionEventEnum.DATACONNECTION_EVENT_DATA, callback: { (obj: NSObject?) -> Void in
            let strValue: String = obj as! String
            
            if self.decisionMessage(type: 1, name: strValue) {
                self.youFight = true
                
            }else if self.decisionMessage(type: 2, name: strValue) {
                DispatchQueue.main.async { self.end() }
                
            }else if self.decisionMessage(type: 3, name: strValue) {
                self.stampAudio(name: strValue)
                DispatchQueue.main.async { self.addStamp(name: strValue) }
                
            }else{
                self.setTime = strValue
            }
        })
        
        // DataConnection closed
        data.on(SKWDataConnectionEventEnum.DATACONNECTION_EVENT_CLOSE, callback: { (obj: NSObject?) -> Void in
            self._data = nil
            self._bEstablished = false
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
                // Realm save function.
                self.idListSave()
                // Pageing
                DispatchQueue.main.async {
                    self.pagingView(selfNib: "", nibName: "EnterRoomView")
                }
            } else {
                // No list data.
                self.alertView(title: "未検出", message: "ペアリング相手が見つかりません", buttonName: "OK")
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
        if _bEstablished == false { return }
        
        _bEstablished = false
        
        if _data != nil { _data?.close() }
    }
    
    func send(_ data: String) {
        let bResult: Bool = (_data?.send(data as NSObject!))!
        
        if bResult == true {
            // OK send
        }
    }
    
    func addStamp(name: String) {
        switch pasteStampCount {
        case 0:
            stampBaseView.stampWidth01.constant = stampBaseView.stamp01.bounds.size.height
            stampBaseView.stamp01.image = UIImage(named: name) // 音声と画像が同じ名前である必要がある
        case 1:
            stampBaseView.stampWidth02.constant = stampBaseView.stamp02.bounds.size.height
            stampBaseView.stamp02.image = UIImage(named: name)
        case 2:
            stampBaseView.stampWidth03.constant = stampBaseView.stamp03.bounds.size.height
            stampBaseView.stamp03.image = UIImage(named: name)
        case 3:
            stampBaseView.stampWidth04.constant = stampBaseView.stamp04.bounds.size.height
            stampBaseView.stamp04.image = UIImage(named: name)
        case 4:
            stampBaseView.stampWidth05.constant = stampBaseView.stamp05.bounds.size.height
            stampBaseView.stamp05.image = UIImage(named: name)
        case 5:
            stampBaseView.stampWidth06.constant = stampBaseView.stamp06.bounds.size.height
            stampBaseView.stamp06.image = UIImage(named: name)
        case 6:
            stampBaseView.stampWidth07.constant = stampBaseView.stamp07.bounds.size.height
            stampBaseView.stamp07.image = UIImage(named: name)
        case 7:
            stampBaseView.stampWidth08.constant = stampBaseView.stamp08.bounds.size.height
            stampBaseView.stamp08.image = UIImage(named: name)
        case 8:
            stampBaseView.stampWidth09.constant = stampBaseView.stamp09.bounds.size.height
            stampBaseView.stamp09.image = UIImage(named: name)
        case 9:
            stampBaseView.stampWidth10.constant = stampBaseView.stamp10.bounds.size.height
            stampBaseView.stamp10.image = UIImage(named: name)
        default:
            pasteStampCount = 0
        }
        
        pasteStampCount += 1
    }
    
    func decisionMessage(type: Int, name: String) -> Bool {
        switch type {
        case 1:
            if (name == "onFight") { return true } else { return false }
        case 2:
            if (name == "end") { return true } else { return false }
        case 3:
            if (nowPage == "WakeUpView") { return true } else { return false }
        default:
            return false
        }
    }
}
