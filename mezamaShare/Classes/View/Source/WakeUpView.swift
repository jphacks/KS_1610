//
//  WakeUpViewController.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class WakeUpView: UIView {
    @IBOutlet weak var fightButton: UIButton!
    @IBOutlet weak var nowTime: UILabel!
    @IBOutlet weak var stamp01: UIImageView!
    @IBOutlet weak var stamp02: UIImageView!
    @IBOutlet weak var stamp03: UIImageView!
    @IBOutlet weak var stamp04: UIImageView!
    @IBOutlet weak var stamp05: UIImageView!
    @IBOutlet weak var stamp06: UIImageView!
    @IBOutlet weak var stamp07: UIImageView!
    @IBOutlet weak var stamp08: UIImageView!
    @IBOutlet weak var stamp09: UIImageView!
    @IBOutlet weak var stamp10: UIImageView!

    @IBOutlet weak var stampWidth01: NSLayoutConstraint!
    @IBOutlet weak var stampWidth02: NSLayoutConstraint!
    @IBOutlet weak var stampWidth03: NSLayoutConstraint!
    @IBOutlet weak var stampWidth04: NSLayoutConstraint!
    @IBOutlet weak var stampWidth05: NSLayoutConstraint!
    @IBOutlet weak var stampWidth06: NSLayoutConstraint!
    @IBOutlet weak var stampWidth07: NSLayoutConstraint!
    @IBOutlet weak var stampWidth08: NSLayoutConstraint!
    @IBOutlet weak var stampWidth09: NSLayoutConstraint!
    @IBOutlet weak var stampWidth10: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        widthInit()
        
        fightButton.addTarget(MainViewController(), action: #selector(MainViewController.onFight(sender:)), for: .touchUpInside)
        
        let audioPlay = AudioPlay()
        var audioPlayDelegate: AudioPlayDelegate? = nil
        
        audioPlayDelegate = audioPlay
        audioPlayDelegate?.setAudio(audioName: "bgm_01")
        audioPlayDelegate?.audioPlay(needsLoop: true)
        
        nowTime.font = UIFont(name: "CometStd-B", size: 40)
    }
    
    func widthInit() {
        stampWidth01.constant = 0
        stampWidth02.constant = 0
        stampWidth03.constant = 0
        stampWidth04.constant = 0
        stampWidth05.constant = 0
        stampWidth06.constant = 0
        stampWidth07.constant = 0
        stampWidth08.constant = 0
        stampWidth09.constant = 0
        stampWidth10.constant = 0
    }
}
