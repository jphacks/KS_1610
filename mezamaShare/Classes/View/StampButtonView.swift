//
//  StampButtonView.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

//        bkImage1.image = UIImage(named: "buttonImage1")

import UIKit

class StampButtonView: UIView {
    
    @IBOutlet weak var bkImage1: UIImageView!
    @IBOutlet weak var bkImage2: UIImageView!
    @IBOutlet weak var bkImage3: UIImageView!
    @IBOutlet weak var bkImage4: UIImageView!
    @IBOutlet weak var bkImage5: UIImageView!
    @IBOutlet weak var bkImage6: UIImageView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    
    
    let audioPlay = AudioPlay()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonSetup()
    }
    
    func buttonSetup(){
        bkImage1.layer.cornerRadius = 10
        bkImage2.layer.cornerRadius = 10
        bkImage3.layer.cornerRadius = 10
        bkImage4.layer.cornerRadius = 10
        bkImage5.layer.cornerRadius = 10
        bkImage6.layer.cornerRadius = 10
        
        button1.addTarget(MainViewController(), action: #selector(MainViewController.onTapButton1(sender:)), for: .touchUpInside)
        button2.addTarget(MainViewController(), action: #selector(MainViewController.onTapButton2(sender:)), for: .touchUpInside)
        button3.addTarget(MainViewController(), action: #selector(MainViewController.onTapButton3(sender:)), for: .touchUpInside)
        button4.addTarget(MainViewController(), action: #selector(MainViewController.onTapButton4(sender:)), for: .touchUpInside)
        button5.addTarget(MainViewController(), action: #selector(MainViewController.onTapButton5(sender:)), for: .touchUpInside)
        button6.addTarget(MainViewController(), action: #selector(MainViewController.onTapButton6(sender:)), for: .touchUpInside)
    }
    
    @IBAction func onTapButton1(_ sender: AnyObject) {
        var audioPlayDelegate: AudioPlayDelegate? = nil
        
        audioPlayDelegate = audioPlay
        audioPlayDelegate?.setAudio(audioName: "mezamashare_zugyuuuun")
        audioPlayDelegate?.audioPlay(needsLoop: false)
    }
    
    @IBAction func onTapButton2(_ sender: AnyObject) {
        var audioPlayDelegate: AudioPlayDelegate? = nil
        
        audioPlayDelegate = audioPlay
        audioPlayDelegate?.setAudio(audioName: "mezamashare_ppap4")
        audioPlayDelegate?.audioPlay(needsLoop: false)
    }
    
    @IBAction func onTapButton3(_ sender: Any) {
        var audioPlayDelegate: AudioPlayDelegate? = nil
        
        audioPlayDelegate = audioPlay
        audioPlayDelegate?.setAudio(audioName: "mezamashare_okiro")
        audioPlayDelegate?.audioPlay(needsLoop: false)
    }
    
    @IBAction func onTapButton4(_ sender: Any) {
        var audioPlayDelegate: AudioPlayDelegate? = nil
        
        audioPlayDelegate = audioPlay
        audioPlayDelegate?.setAudio(audioName: "mezamashare_sukida")
        audioPlayDelegate?.audioPlay(needsLoop: false)
    }
    
    @IBAction func onTapButton5(_ sender: AnyObject) {
        
    }
    
    @IBAction func onTapButton6(_ sender: AnyObject) {
//        var audioPlayDelegate: AudioPlayDelegate? = nil
//        
//        audioPlayDelegate = audioPlay
//        audioPlayDelegate?.setAudio(audioName: "bgm_01")
//        audioPlayDelegate?.audioPlay(needsLoop: true)
    }
}
