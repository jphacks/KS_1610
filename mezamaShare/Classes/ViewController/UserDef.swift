//
//  UserDef.swift
//  mezamaShare
//
//  Created by Ellie NAGAISHI on 2016/10/29.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class UserDef: NSObject {
    
    let userDef: UserDefaults = UserDefaults.init()

    func dataLoad(key: String) -> String {
        if userDef.string(forKey: key) == nil {
            dataSet(data: "Error", key: key)
        }
        return userDef.string(forKey: key)!
    }
    
    func dataSet(data: String, key: String) -> Bool {
        userDef.set(data, forKey:key)
        if userDef.string(forKey: key) != nil {
            return true
        } else {
            return false
        }
    }
}
