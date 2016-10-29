//
//  StampButtonView.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class StampButtonView: UIView {
    
    @IBOutlet weak var bkImage1: UIImageView!
    @IBOutlet weak var bkImage2: UIImageView!
    @IBOutlet weak var bkImage3: UIImageView!
    @IBOutlet weak var bkImage4: UIImageView!
    @IBOutlet weak var bkImage5: UIImageView!
    @IBOutlet weak var bkImage6: UIImageView!
    
    // let audioPlay = AudioPlay()
    // var audioPlayDelegate: AudioPlayDelegate? = nil
    //
    // audioPlayDelegate = audioPlay
    // audioPlayDelegate?.setAudio(audioName: "bgm_01")
    // audioPlayDelegate?.audioPlay(needsLoop: false)
    
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
        
        bkImage1.image = UIImage(named: "buttonImage1")
        bkImage2.image = UIImage(named: "buttonImage2")
        bkImage3.image = UIImage(named: "buttonImage3")
        bkImage4.image = UIImage(named: "buttonImage4")
        bkImage5.image = UIImage(named: "buttonImage5")
        bkImage6.image = UIImage(named: "buttonImage6")
    }
    
    @IBAction func onTapButton1(_ sender: AnyObject) {
    }
    
    @IBAction func onTapButton2(_ sender: AnyObject) {
    }
    
    @IBAction func onTapButton3(_ sender: AnyObject) {
    }
    
    @IBAction func onTapButton4(_ sender: AnyObject) {
    }
    
    @IBAction func onTapButton5(_ sender: AnyObject) {
    }
    
    @IBAction func onTapButton6(_ sender: AnyObject) {
    }
}
