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
    
    
//    let audioPlay = AudioPlay()
    let audioPlay: [AudioPlay] = [AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay(), AudioPlay()]
    var audioPlayerCount: Int = 0
    
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
}
