//
//  CreateRoomViewController.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class CreateRoomViewController: UIView {
    
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var minites: UILabel!
    @IBOutlet weak var makeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeButton.addTarget(MainViewController(), action: #selector(MainViewController.onMakrRoom(sender:)), for: .touchUpInside)
    }
    
    @IBAction func onHour(_ sender: Any) {
        hour.text = (sender as AnyObject).value
    }
    
    @IBAction func omMinites(_ sender: Any) {
        minites.text = (sender as AnyObject).value
    }
}
