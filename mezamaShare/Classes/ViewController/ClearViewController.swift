//
//  ClearViewController.swift
//  mezamaShare
//
//  Created by Akio Itaya on 2016/10/30.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class ClearViewController: UIView {

    @IBOutlet weak var returnButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        returnButton.addTarget(MainViewController(), action: #selector(MainViewController.onReturn(sender:)), for: .touchUpInside)
    }
}
