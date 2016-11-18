//
//  SelectStampController.swift
//  mezamaShare
//
//  Created by AKIO on 2016/11/18.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

extension MainViewController {
    func arc4random(lower: UInt32, upper: UInt32) -> UInt32 {
        guard upper >= lower else {
            return 0
        }
        return arc4random_uniform(upper - lower) + lower
    }
    
    func setupStamp() {
        let saName: [String] = ["s_01_apple-pen","s_02_apple","s_03_asa-dayo","s_04_dododo","s_05_hai-okite","s_06_horihori","s_07_oh-yes","s_08_ohayo","s_09_okiro", "s_10_pen", "s_11_pineapple-pen", "s_12_pineapple", "s_13_ppap", "s_14_sukida", "s_15_zugyuuuun"]
        var outSAName: [Int] = [0, 0, 0, 0]
        var outSANameString: [String] = ["", "", "", ""]
        
        var num: [Int] = []
        
        var j: Int = 0
        for _ in saName {
            num.append(j)
            j += 1
        }
        
        var i: Int = 0
        for _ in 0 ... 3 {
            outSAName[i] = num[Int(arc4random(lower: 0, upper: UInt32(num.count - 1)))]
            
            // Reset array -----
            let tmpNumCount: Int = num.count
            num = []
            var k: Int = 0
            for _ in 0 ... (tmpNumCount - 1) {
                if outSAName[i] != k {
                    num.append(k)
                }
                k += 1
            }
            // -----------------
            
            i += 1
        }
        
        var l: Int = 0
        for _ in outSAName {
            outSANameString[l] = saName[outSAName[l]]
            l += 1
        }
        
        userDefault.set(outSANameString, forKey: "SAName")
        userDefault.synchronize()
        
        /* out put array data
         *
        var names: [String] = []
        if((userDefault.object(forKey: "SAName")) != nil){
            let objects = userDefault.object(forKey: "SAName") as? NSArray
            
            for nameString in objects!{
                names.append((nameString as! NSString) as String)
            }
        }
        */
    }
}
