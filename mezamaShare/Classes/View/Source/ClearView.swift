//
//  ClearViewController.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/30.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class ClearView: UIView {

    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var pointLabel: UILabel!
    private let userDefault = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pointLabel.text = "0"
        pointLabel.font = UIFont(name: "CometStd-B", size: 30)
        
        returnButton.addTarget(MainViewController(), action: #selector(MainViewController.onReturn(sender:)), for: .touchUpInside)
        if userDefault.object(forKey: "tapCount") != nil {
            pointLabel.text = String( describing: userDefault.integer(forKey: "tapCount"))
        }
    }
}
