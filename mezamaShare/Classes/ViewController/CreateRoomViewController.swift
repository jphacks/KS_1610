//
//  CreateRoomViewController.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class CreateRoomViewController: UIView {
    
    @IBOutlet weak var makeButton: UIButton!
    @IBOutlet weak var inputID: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    private var setTime: String = "00:00"
    private let userDefault = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeButton.addTarget(MainViewController(), action: #selector(MainViewController.onMakrRoom(sender:)), for: .touchUpInside)
        inputID.addTarget(MainViewController(), action: #selector(MainViewController.onInputID(sender:)), for: .touchUpInside)
        timePicker.setValue(UIColor.white, forKey: "textColor")
        timePicker.setValue(false, forKey: "highlightsToday")
    }
    
    @IBAction func onTimePicker(_ sender: UIDatePicker) {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        setTime = format.string(from: sender.date)
        
        userDefault.set(setTime, forKey: "setTime")
        userDefault.synchronize()
    }
}
