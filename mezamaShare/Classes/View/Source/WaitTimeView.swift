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
    var timer: Timer!
    var stringDate: String = "00:00"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roomNameLabel.font = UIFont(name: "CometStd-B", size: 20)
        
        if userDefault.object(forKey: "myID") != nil {
            roomNameLabel.text = userDefault.object(forKey: "myID") as? String
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.checkTime), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func checkTime(sender: Timer) {
        let now = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        print(formatter.string(from: now as Date))
        
        
        if userDefault.object(forKey: "setTime") != nil {
            stringDate = userDefault.object(forKey: "setTime") as! String
        }
        print(stringDate)
        print(formatter.date(from: stringDate))
    }
}
