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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        fightButton.addTarget(MainViewController(), action: #selector(MainViewController.onFight(sender:)), for: .touchUpInside)
        
        let audioPlay = AudioPlay()
        var audioPlayDelegate: AudioPlayDelegate? = nil
        
        audioPlayDelegate = audioPlay
        audioPlayDelegate?.setAudio(audioName: "bgm_01")
        audioPlayDelegate?.audioPlay(needsLoop: true)
    }
}
