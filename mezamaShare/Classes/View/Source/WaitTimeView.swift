//
//  WaitTimeViewController.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class WaitTimeView: UIView {
    @IBOutlet weak var roomNameLabel: UILabel!
    private let userDefault = UserDefaults.standard

    override func awakeFromNib() {
        super.awakeFromNib()
        
        roomNameLabel.font = UIFont(name: "CometStd-B", size: 20)
        
        if userDefault.object(forKey: "myID") != nil {
            roomNameLabel.text = userDefault.object(forKey: "myID") as? String
        }
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector(("checkTime:")), userInfo: nil, repeats: true)
    }
    
    func checkTime(sender: Timer) {
        print("on timer")
    }
}
