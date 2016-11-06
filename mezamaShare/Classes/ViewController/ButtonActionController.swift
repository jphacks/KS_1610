//
//  ButtonActionController.swift
//  mezamaShare
//
//  Created by AKIO on 2016/11/06.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

extension MainViewController {
    // Alert button.
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
    }
    
    func onTapButton6(sender: UIButton) {
    }
}

extension MainViewController {
    // Paging button.
    func onHomeMakeRoom(sender: UIButton) {
        pagingView(selfNib: "", nibName: "CreateRoomView")
    }
    
    func onHomeEnterRoom(sender: UIButton) {
        if _data == nil { self.getPeerList() }
    }
    
    func onMakrRoom(sender: UIButton) {
        if _bEstablished {
            hasDate()
        }else{
            alertView(title: "接続未完了", message: "メンバーが接続するまでお待ち下さい", buttonName: "OK")
        }
    }
    
    func hasDate() {
        if userDefault.object(forKey: "setTime") != nil {
            setTime = userDefault.object(forKey: "setTime") as! String
            send(setTime)
            pagingView(selfNib: "", nibName: "WaitTimeView")
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        } else {
            alertView(title: "エラー", message: "起床時間のロードに失敗しました", buttonName: "OK")
        }
    }
    
    func onEnterRoom(sender: UIButton) {
        // Load id list by Realm.
        connect(idListLoad())
        
        if setTime != "" { // 再度やるときは初期化必要
            pagingView(selfNib: "", nibName: "WaitTimeView")
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        } else {
            alertView(title: "起床時未設定", message: "メンバーが設定するまでお待ち下さい", buttonName: "OK")
        }
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
}
