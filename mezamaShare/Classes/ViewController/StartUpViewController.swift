//
//  StartUpViewController.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/30.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class StartUpViewController: UIView {

    @IBOutlet weak var homeMakeRoom: UIButton!
    @IBOutlet weak var homeEnterRoom: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        homeMakeRoom.addTarget(MainViewController(), action: #selector(MainViewController.onHomeMakeRoom(sender:)), for: .touchUpInside)
        homeEnterRoom.addTarget(MainViewController(), action: #selector(MainViewController.onHomeEnterRoom(sender:)), for: .touchUpInside)
    }
}
