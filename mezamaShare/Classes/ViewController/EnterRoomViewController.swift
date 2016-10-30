//
//  EnterRoomViewController.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class EnterRoomViewController: UIView {
    @IBOutlet weak var enterButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        enterButton.addTarget(MainViewController(), action: #selector(MainViewController.onEnterRoom(sender:)), for: .touchUpInside)
    }
}
