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
    @IBOutlet weak var myID: UILabel!
    private let userDefault = UserDefaults.standard

    override func awakeFromNib() {
        super.awakeFromNib()
        if userDefault.object(forKey: "myID") != nil {
            roomNameLabel.text = userDefault.object(forKey: "myID") as? String
            myID.text = userDefault.object(forKey: "myID") as? String
        }
    }
}
